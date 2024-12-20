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
    static let archive = FileType(asset: "file-archive", types: [.archive])
    static let audio = FileType(asset: "file-audio", types: [.audio])
    static let code = FileType(asset: "file-code", types: [.sourceCode, .html, .json, .xml])
    static let doc = FileType(asset: "file-doc", types: [.text, .pages, .onlyOffice, .wordDoc, .wordDocm, .wordDocx])
    static let font = FileType(asset: "file-font", types: [.font])
    static let grid = FileType(asset: "file-grid", types: [.spreadsheet])
    static let ics = FileType(asset: "file-ics", types: [.calendarEvent, .ics])
    static let image = FileType(asset: "file-img", types: [.image])
    static let pdf = FileType(asset: "file-pdf", types: [.pdf])
    static let point = FileType(asset: "file-point", types: [.presentation])
    static let vCard = FileType(asset: "file-vcard", types: [.vCard])
    static let video = FileType(asset: "file-video", types: [.video, .movie])

    static let unknown = FileType(asset: "file-unknown", types: [])
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

    private init(asset: String, types: [UTType]) {
        self.init(image: Image(asset, bundle: .module), color: Color("\(asset)-color", bundle: .module), types: types)
    }

    public func conforms(to type: UTType) -> Bool {
        return types.contains { conformingType in
            type.conforms(to: conformingType)
        }
    }
}
