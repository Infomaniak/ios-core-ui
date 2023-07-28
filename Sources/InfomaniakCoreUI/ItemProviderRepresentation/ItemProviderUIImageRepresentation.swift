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
import UIKit

/// Something that can provide a `Progress` and an async `Result` in order to make an image file from a `NSItemProvider` wrapping
/// an UIImage
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public final class ItemProviderUIImageRepresentation: NSObject, ProgressResultable {
    /// Something to transform events into a nice `async Result`
    private let flowToAsync = FlowToAsyncResult<Success>()

    /// Domain specific errors
    public enum ErrorDomain: Error {
        case UTINotSupported
        case unableToGetPNGData
        case unknown
    }

    public typealias Success = URL
    public typealias Failure = Error

    private static let progressStep: Int64 = 1

    public init(from itemProvider: NSItemProvider) throws {
        // It must be a directory for the OS to zip it for us, a file returns a file
        guard itemProvider.underlyingType == .isUIImage else {
            throw ErrorDomain.UTINotSupported
        }

        progress = Progress(totalUnitCount: 1)

        super.init()

        let childProgress = Progress()
        progress.addChild(childProgress, withPendingUnitCount: Self.progressStep)

        itemProvider.loadItem(forTypeIdentifier: UTI.image.identifier) { [self] coding, error in
            defer {
                childProgress.completedUnitCount += Self.progressStep
            }

            guard error == nil, coding != nil else {
                flowToAsync.sendFailure(error ?? ErrorDomain.unknown)
                return
            }

            // Try to get png from UIImage
            guard let image = coding as? UIImage,
                  let pngData = image.pngData() else {
                flowToAsync.sendFailure(ErrorDomain.unableToGetPNGData)
                return
            }

            do {
                // Use a unique folder to prevent collisions
                let tmpDirectoryURL = try URL.temporaryUniqueFolderURL()

                let targetURL = tmpDirectoryURL.appendingPathComponent("\(URL.defaultFileName()).png")

                try pngData.write(to: targetURL, options: .atomic)
                flowToAsync.sendSuccess(targetURL)
            } catch {
                flowToAsync.sendFailure(error)
            }
        }
    }

    // MARK: Public

    public var progress: Progress

    public var result: Result<URL, Error> {
        get async {
            return await flowToAsync.result
        }
    }
}

#endif
