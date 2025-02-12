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
import Kingfisher
import UIKit

public extension InfomaniakUser {
    /// Can fetch an avatar from any abstract `InfomaniakUser`
    func getAvatar(size: CGSize = CGSize(width: 40, height: 40), completion: @escaping (UIImage) -> Void) {
        guard let avatarString = avatar,
              let url = URL(string: avatarString) else {
            completion(defaultAvatar(size: size))
            return
        }

        KingfisherManager.shared.retrieveImage(with: url) { result in
            if let avatarImage = try? result.get().image {
                completion(avatarImage)
            } else {
                completion(self.defaultAvatar(size: size))
            }
        }
    }

    private func defaultAvatar(size: CGSize) -> UIImage {
        let backgroundColor = UIColor.backgroundColor(from: id)
        return UIImage.getInitialsPlaceholder(with: displayName, size: size, backgroundColor: backgroundColor)
    }

    func getAvatar(size: CGSize = CGSize(width: 40, height: 40)) async -> UIImage {
        return await withCheckedContinuation { continuation in
            self.getAvatar(size: size) { image in
                continuation.resume(returning: image)
            }
        }
    }
}
