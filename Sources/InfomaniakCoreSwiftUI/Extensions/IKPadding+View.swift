/*
 Infomaniak Core UI - iOS
 Copyright (C) 2025 Infomaniak Network SA

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

import InfomaniakCoreCommonUI
import SwiftUI

public extension View {
    /// Adds the padding amount specified by ``IKPadding`` to specific edges
    /// of this view.
    ///
    /// - Parameters:
    ///  - edges: The set of edges to pad for this view. The default
    ///      is `Edge.Set = .all`.
    ///  - value: The amount of padding described by the ``IKPadding``
    ///      struct.
    ///
    /// - Returns: A view that's padded by the specified amount on the specified edges.
    @inlinable func padding(_ edges: Edge.Set = .all, value: IKPadding.Option) -> some View {
        padding(edges, value.rawValue)
    }
}
