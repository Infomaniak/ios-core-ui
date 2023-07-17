/*
 Infomaniak Mail - iOS App
 Copyright (C) 2022 Infomaniak Network SA

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#if canImport(MobileCoreServices)

import Combine
import InfomaniakCore
import InfomaniakDI
import UIKit

/// Something that can provide a `Progress` and an async `Result` in order to make an image file from a `NSItemProvider` wrapping
/// an UIImage
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public final class ItemProviderUIImageRepresentation: NSObject, ProgressResultable {
    /// Domain specific errors
    public enum ErrorDomain: Error {
        case UTINotFound
        case UTINotSupported
        case unknown
    }

    public typealias Success = URL
    public typealias Failure = Error

    private static let progressStep: Int64 = 1

    /// Track task progress with internal Combine pipe
    private let resultProcessed = PassthroughSubject<Success, Failure>()

    /// Internal observation of the Combine progress Pipe
    private var resultProcessedObserver: AnyCancellable?

    /// Internal Task that wraps the combine result observation
    private var computeResultTask: Task<Success, Failure>?

    public init(from itemProvider: NSItemProvider) throws {
        guard let typeIdentifier = itemProvider.registeredTypeIdentifiers.first else {
            throw ErrorDomain.UTINotFound
        }

        progress = Progress(totalUnitCount: 1)

        super.init()

        let childProgress = Progress()
        progress.addChild(childProgress, withPendingUnitCount: Self.progressStep)

        itemProvider.loadItem(forTypeIdentifier: UTI.image.identifier) { coding, error in
            defer {
                childProgress.completedUnitCount += Self.progressStep
            }

            guard error == nil, coding != nil else {
                self.resultProcessed.send(completion: .failure(error ?? ErrorDomain.unknown))
                return
            }

            @InjectService var pathProvider: AppGroupPathProvidable
            let tmpDirectoryURL = pathProvider.tmpDirectoryURL

            // Is UIImage
            if let image = coding as? UIImage,
               let pngData = image.pngData() {
                let targetURL = tmpDirectoryURL.appendingPathComponent("\(UUID().uuidString).png")

                do {
                    try pngData.write(to: targetURL, options: .atomic)
                    self.resultProcessed.send(targetURL)
                    self.resultProcessed.send(completion: .finished)
                } catch {
                    self.resultProcessed.send(completion: .failure(error))
                }
            }

            // Not supported
            else {
                self.resultProcessed.send(completion: .failure(ErrorDomain.UTINotSupported))
            }
        }

        /// Wrap the Combine pipe to a native Swift Async Task for convenience
        computeResultTask = Task {
            let resultURL: URL = try await withCheckedThrowingContinuation { continuation in
                self.resultProcessedObserver = resultProcessed.sink { result in
                    switch result {
                    case .finished:
                        break
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                    self.resultProcessedObserver?.cancel()
                } receiveValue: { value in
                    continuation.resume(with: .success(value))
                }
            }

            return resultURL
        }
    }

    // MARK: Public

    public var progress: Progress

    public var result: Result<URL, Error> {
        get async {
            guard let computeResultTask else {
                fatalError("This never should be nil")
            }

            return await computeResultTask.result
        }
    }
}

#endif
