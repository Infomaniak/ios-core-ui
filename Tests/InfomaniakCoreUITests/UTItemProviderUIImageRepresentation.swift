/*
 Infomaniak Core UI - iOS
 Copyright (C) 2023 Infomaniak Network SA

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

import InfomaniakCore
import InfomaniakCoreCommonUI
@testable import InfomaniakDI
import UIKit
import XCTest

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
final class UTItemProviderUIImageRepresentation: XCTestCase {
    private let fileManager = FileManager.default

    override class func setUp() {
        let factory = Factory(
            type: AppGroupPathProvidable.self
        ) { _, _ in
            return AppGroupPathProvider(realmRootPath: "realm", appGroupIdentifier: "com.ik.test")!
        }
        SimpleResolver.sharedResolver.store(factory: factory)
    }

    override class func tearDown() {
        SimpleResolver.sharedResolver.removeAll()
    }

    func cleanFile(_ url: URL) {
        try? fileManager.removeItem(at: url)
    }

    // MARK: -

    func testGetPNG() async {
        // GIVEN
        let image = UIImage(systemName: "multiply.circle.fill")
        let item = NSItemProvider(item: image, typeIdentifier: UTI.image.rawValue as String)

        do {
            let provider = try ItemProviderUIImageRepresentation(from: item)
            let progress = provider.progress
            XCTAssertFalse(progress.isFinished, "Expecting the progress to reflect that the task has not started yet")
            
            // WHEN
            let success = try await provider.result.get()

            // THEN
            XCTAssertTrue(progress.isFinished, "Expecting the progress to reflect that the task is finished")
            let filename = success.lastPathComponent
            XCTAssertFalse(filename.isEmpty, "we expect a file name")
            XCTAssertTrue(filename.hasSuffix(".png"), "we expect a PNG file extension")
            XCTAssertGreaterThanOrEqual(filename.count, 17 + ".png".count, "non empty title")
            XCTAssertLessThanOrEqual(filename.count, 30 + ".png".count, "smaller than UUID")

        } catch {
            XCTFail("Unexpected \(error)")
        }
    }

    func testGetPNGFromEmptyImage() async {
        // GIVEN
        let image = UIImage()
        let item = NSItemProvider(item: image, typeIdentifier: UTI.image.rawValue as String)

        do {
            // WHEN
            let _ = try ItemProviderUIImageRepresentation(from: item)

            // THEN
            // expected to throw unableToGetPNGData
        } catch {
            guard let error = error as? ItemProviderUIImageRepresentation.ErrorDomain else {
                XCTFail("Unexpected error type \(error)")
                return
            }

            guard case ItemProviderUIImageRepresentation.ErrorDomain.unableToGetPNGData = error else {
                XCTFail("Unexpected error case \(error)")
                return
            }

            // All good
        }
    }

    func testGetPNGWrongInputType() async {
        // GIVEN
        let notAnImage = UIColor.red // Something that conforms to NSCoding
        let item = NSItemProvider(item: notAnImage, typeIdentifier: UTI.image.rawValue as String)

        do {
            // WHEN
            let _ = try ItemProviderUIImageRepresentation(from: item)

            // THEN
            // expected to throw unableToGetPNGData
        } catch {
            guard let error = error as? ItemProviderUIImageRepresentation.ErrorDomain else {
                XCTFail("Unexpected error type \(error)")
                return
            }

            guard case ItemProviderUIImageRepresentation.ErrorDomain.unableToGetPNGData = error else {
                XCTFail("Unexpected error case \(error)")
                return
            }

            // All good
        }
    }

    func testGetPNG_wrongUTI() async {
        // GIVEN
        let image = UIImage(systemName: "multiply.circle.fill")
        let item = NSItemProvider(item: image, typeIdentifier: UTI.audio.rawValue as String)

        do {
            let provider = try ItemProviderUIImageRepresentation(from: item)

            // WHEN
            let _ = try await provider.result.get()

            // THEN
            // expected to throw UTINotSupported
        } catch {
            guard let error = error as? ItemProviderUIImageRepresentation.ErrorDomain else {
                XCTFail("Unexpected error type \(error)")
                return
            }

            guard case ItemProviderUIImageRepresentation.ErrorDomain.UTINotSupported = error else {
                XCTFail("Unexpected error case \(error)")
                return
            }

            // All good
        }
    }
}

#endif
