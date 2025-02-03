//
//  File.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 03/02/2025.
//

import SwiftUI

@available(iOS 15.0, *)
extension FormatStyle where Self == ByteCountFormatStyle {
    static var defaultByteCount: ByteCountFormatStyle {
        return .byteCount(style: .binary)
    }
}
