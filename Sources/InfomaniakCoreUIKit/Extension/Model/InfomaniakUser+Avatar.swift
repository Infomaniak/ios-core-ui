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

import InfomaniakCore
import Nuke
import UIKit

public extension InfomaniakUser {
    /// Can fetch an avatar from any abstract `InfomaniakUser`
    func getAvatar(size: CGSize = CGSize(width: 40, height: 40), completion: @MainActor @escaping (UIImage) -> Void) {
        let id = self.id
        let displayName = self.displayName
        let avatar = self.avatar

        Task {
            let avatarImage = await getAvatar(id: id, displayName: displayName, avatar: avatar, size: size)
            await completion(avatarImage)
        }
    }

    private func defaultAvatar(id: Int, displayName: String, size: CGSize) -> UIImage {
        let backgroundColor = UIColor.backgroundColor(from: id)
        return UIImage.getInitialsPlaceholder(with: displayName, size: size, backgroundColor: backgroundColor)
    }

    private func getAvatar(id: Int, displayName: String, avatar: String?, size: CGSize) async -> UIImage {
        guard let avatarString = avatar,
              let url = URL(string: avatarString) else {
            return defaultAvatar(id: id, displayName: displayName, size: size)
        }

        guard let avatarImage = try? await ImagePipeline.shared.image(for: url) else {
            return defaultAvatar(id: id, displayName: displayName, size: size)
        }

        return avatarImage
    }

    func getAvatar(size: CGSize = CGSize(width: 40, height: 40)) async -> UIImage {
        return await getAvatar(id: id, displayName: displayName, avatar: avatar, size: size)
    }
}
