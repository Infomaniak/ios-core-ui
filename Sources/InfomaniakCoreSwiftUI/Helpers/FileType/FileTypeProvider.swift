/*
 Infomaniak Core UI - iOS
 Copyright (C) 2024 Infomaniak Network SA

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

import SwiftUI
import UniformTypeIdentifiers

@available(iOS 14.0, *)
public struct FileTypeProvider: Sendable {
    private static let checkableFileTypes: [FileType] = [
        .archive, .audio, .code, .doc, .font, .grid, .ics, .image, .pdf, .point, .video
    ]

    public let uti: UTType?
    public let fileType: FileType

    public var image: Image {
        fileType.image
    }

    public var color: Color {
        fileType.color
    }

    public init(type: String) {
        self.init(uti: UTType(type))
    }

    public init(uti: UTType?) {
        self.uti = uti
        fileType = FileTypeProvider.guessFileType(from: uti)
    }

    private static func guessFileType(from type: UTType?) -> FileType {
        guard let type else { return .unknown }

        for fileType in checkableFileTypes {
            if fileType.conform(to: type) {
                return fileType
            }
        }

        return .unknown
    }
}
