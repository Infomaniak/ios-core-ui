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
public extension UTType {
    static let pages = UTType("com.apple.iwork.pages.sffpages")!
    static let wordDoc = UTType("com.microsoft.word.doc")!
    static let wordDocm = UTType(mimeType: "application/vnd.ms-word")!
    static let wordDocx = UTType("org.openxmlformats.wordprocessingml.document")!
    static let onlyOffice = UTType("org.oasis-open.opendocument.text")!

    static let ics = UTType(mimeType: "application/ics")!
}

@available(iOS 14.0, *)
public extension FileType {
    static let archive = FileType(image: .fileArchive, color: .fileArchive, types: [.archive])
    static let audio = FileType(image: .fileAudio, color: .fileAudio, types: [.audio])
    static let code = FileType(image: .fileCode, color: .fileCode, types: [.sourceCode, .html, .json, .xml])
    static let doc = FileType(
        image: .fileDoc,
        color: .fileDoc,
        types: [.text, .pages, .onlyOffice, .wordDoc, .wordDocm, .wordDocx]
    )
    static let font = FileType(image: .fileFont, color: .fileFont, types: [.font])
    static let grid = FileType(image: .fileGrid, color: .fileGrid, types: [.spreadsheet])
    static let ics = FileType(image: .fileIcs, color: .fileIcs, types: [.calendarEvent, .ics])
    static let image = FileType(image: .fileImg, color: .fileImg, types: [.image])
    static let pdf = FileType(image: .filePdf, color: .filePdf, types: [.pdf])
    static let point = FileType(image: .filePoint, color: .filePoint, types: [.presentation])
    static let video = FileType(image: .fileVideo, color: .fileVideo, types: [.video])

    static let unknown = FileType(image: .fileVcard, color: .fileVcard, types: [.vCard])
}

@available(iOS 14.0, *)
public struct FileType: Sendable {
    public let image: Image
    public let color: Color
    public let types: [UTType]

    public init(image: Image, color: Color, types: [UTType]) {
        self.image = image
        self.color = color
        self.types = types
    }

    private init(image: ImageResource, color: ColorResource, types: [UTType]) {
        self.init(image: Image(image), color: Color(color), types: types)
    }

    public func conform(to type: UTType) -> Bool {
        return types.contains(type)
    }
}
