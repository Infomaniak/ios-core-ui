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

import Foundation

import UIKit

public extension UICollectionView {
    enum UICollectionViewSupplementaryViewKind: RawRepresentable {
        public init(rawValue: String) {
            switch rawValue {
            case UICollectionView.elementKindSectionHeader:
                self = .header
            case UICollectionView.elementKindSectionFooter:
                self = .footer
            default:
                self = .custom(rawValue)
            }
        }

        public var rawValue: String {
            switch self {
            case .header:
                return UICollectionView.elementKindSectionHeader
            case .footer:
                return UICollectionView.elementKindSectionFooter
            case .custom(let customValue):
                return customValue
            }
        }

        case header
        case footer
        case custom(String)
    }

    func register(cellView: AnyClass) {
        let name = String(describing: cellView.self)
        register(UINib(nibName: name, bundle: nil), forCellWithReuseIdentifier: name)
    }

    func dequeueReusableCell<CellClass: UICollectionViewCell>(type: CellClass.Type, for indexPath: IndexPath) -> CellClass {
        return dequeueReusableCell(withReuseIdentifier: String(describing: type.self), for: indexPath) as! CellClass
    }

    func register(supplementaryView: AnyClass, forSupplementaryViewOfKind: UICollectionViewSupplementaryViewKind) {
        let name = String(describing: supplementaryView.self)
        register(UINib(nibName: name, bundle: nil), forSupplementaryViewOfKind: forSupplementaryViewOfKind.rawValue, withReuseIdentifier: name)
    }

    func dequeueReusableSupplementaryView<ViewClass: UICollectionReusableView>(ofKind: UICollectionViewSupplementaryViewKind, view: ViewClass.Type, for indexPath: IndexPath) -> ViewClass {
        return dequeueReusableSupplementaryView(ofKind: ofKind.rawValue, withReuseIdentifier: String(describing: view.self), for: indexPath) as! ViewClass
    }

    func dequeueReusableSupplementaryView<ViewClass: UICollectionReusableView>(ofKind: String, view: ViewClass.Type, for indexPath: IndexPath) -> ViewClass {
        return dequeueReusableSupplementaryView(ofKind: ofKind, withReuseIdentifier: String(describing: view.self), for: indexPath) as! ViewClass
    }
}
