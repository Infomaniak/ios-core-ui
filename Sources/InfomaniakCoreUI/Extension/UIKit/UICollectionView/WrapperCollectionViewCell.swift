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

import UIKit

/// Wrapping a UITableViewCell in a UICollectionViewCell
public final class WrapperCollectionViewCell: UICollectionViewCell {
    /// The wrapped instance of the cell
    public var wrappedCell: UITableViewCell?

    // MARK: Reuse

    /// Wrap a new cell into this existing one
    /// - Parameter cellType: The type used to refresh the cell. It must be created in a XIB
    public func reuse<CellClass: UITableViewCell>(withCellType cellType: CellClass.Type) -> CellClass {
        prepareForReuse()

        let wrappedCell = Bundle.main.loadNibNamed(String(describing: cellType),
                                                   owner: nil,
                                                   options: nil)![0] as! CellClass
        self.wrappedCell = wrappedCell
        setupAutolayout()

        return wrappedCell
    }

    override public func prepareForReuse() {
        contentView.subviews.forEach { $0.removeFromSuperview() }
    }

    // MARK: Layout

    private func setupAutolayout() {
        guard let wrappedCell = wrappedCell else {
            return
        }

        let cellContentView = wrappedCell.contentView
        contentView.addSubview(cellContentView)

        cellContentView.translatesAutoresizingMaskIntoConstraints = false
        let top = NSLayoutConstraint(
            item: cellContentView,
            attribute: .top,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .top,
            multiplier: 1,
            constant: 0
        )
        let bottom = NSLayoutConstraint(
            item: cellContentView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        )
        let left = NSLayoutConstraint(
            item: cellContentView,
            attribute: .left,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .left,
            multiplier: 1,
            constant: 0
        )
        let right = NSLayoutConstraint(
            item: cellContentView,
            attribute: .right,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .right,
            multiplier: 1,
            constant: 0
        )

        let height = NSLayoutConstraint(
            item: contentView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: cellContentView.frame.height
        )

        NSLayoutConstraint.activate([top, bottom, left, right, height])
    }
}
