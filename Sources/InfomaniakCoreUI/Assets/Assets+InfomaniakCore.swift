/*
Infomaniak Core - iOS
Copyright (C) 2021 Infomaniak Network SA

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

// swiftlint:disable all
#if os(macOS)
    import AppKit
#elseif os(iOS)
    import UIKit
#elseif os(tvOS) || os(watchOS)
    import UIKit
#endif
// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum InfomaniakCoreAsset {
    public static let backgroundCardView = InfomaniakCoreColor(name: "backgroundCardView")
    public static let backgroundCardViewSelected = InfomaniakCoreColor(name: "backgroundCardViewSelected")
    public static let titleColor = InfomaniakCoreColor(name: "titleColor")
    public static let primaryTextColor = InfomaniakCoreColor(name: "primaryTextColor")
    public static let infomaniakColor = InfomaniakCoreColor(name: "infomaniakColor")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details
public struct InfomaniakCoreColor {
    public fileprivate(set) var name: String

    public var color: UIColor {
        return UIColor(named: name, in: Bundle.module, compatibleWith: nil)!
    }

}
