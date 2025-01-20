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

import InfomaniakCoreSwiftUI
import SwiftUI

struct MyKsuiteView: View {
    let isDrive = true

    var body: some View {
        Text("close", bundle: .module)
        Text("title", bundle: .module)
        Text("description", bundle: .module)

        if isDrive {
            Text("kdriveLabel1", bundle: .module)
            Text("kdriveLabel2", bundle: .module)
            Text("label3", bundle: .module)
        } else {
            Text("kmailLabel1", bundle: .module)
            Text("kmailLabel2", bundle: .module)
            Text("label3", bundle: .module)
        }

        Text("details", bundle: .module)

        Button {} label: {
            Text("close", bundle: .module)
        }
    }
}

#Preview {
    MyKsuiteView()
}
