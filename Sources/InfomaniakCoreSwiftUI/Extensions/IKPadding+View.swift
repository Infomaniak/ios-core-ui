//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the License is distributed on an
//  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//  KIND, either express or implied.  See the License for the
//  specific language governing permissions and limitations
//  under the License.

import DesignSystem
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
