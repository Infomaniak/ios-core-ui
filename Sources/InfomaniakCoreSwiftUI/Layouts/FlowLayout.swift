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

@available(iOS 16.0, *)
public struct FlowLayout: Layout {
    private let alignment: Alignment
    private let verticalSpacing: CGFloat
    private let horizontalSpacing: CGFloat

    public init(alignment: Alignment = .center, verticalSpacing: CGFloat = .zero, horizontalSpacing: CGFloat = .zero) {
        self.alignment = alignment
        self.verticalSpacing = verticalSpacing
        self.horizontalSpacing = horizontalSpacing
    }

    public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let (size, _) = computeLayout(proposal: proposal, subviews: subviews)
        return size
    }

    public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let (size, offsetsPerLine) = computeLayout(proposal: proposal, subviews: subviews)
        let alignmentOffsets = computeAlignmentOffsets(containerWidth: size.width, offsets: offsetsPerLine)

        var subviewIndex = 0
        for line in offsetsPerLine.indices {
            for offset in offsetsPerLine[line] {
                let subview = subviews[subviewIndex]
                subview.place(
                    at: CGPoint(
                        x: bounds.minX + offset.minX + alignmentOffsets[line],
                        y: bounds.minY + offset.minY
                    ),
                    proposal: ProposedViewSize(subview.sizeThatFits(.unspecified))
                )

                subviewIndex += 1
            }
        }
    }

    private func computeLayout(proposal: ProposedViewSize, subviews: Subviews) -> (CGSize, [[CGRect]]) {
        let availableWidth = proposal.width ?? .infinity

        var offsets: [[CGRect]] = [[]]

        var currentPosition = CGPoint.zero
        var currentLine = 0
        var maximumLineWidth = CGFloat.zero
        var currentLineHeight = CGFloat.zero

        for index in subviews.indices {
            let subview = subviews[index]

            let size = subview.sizeThatFits(.unspecified)

            if currentPosition.x + size.width > availableWidth {
                currentPosition.x = 0
                currentPosition.y += currentLineHeight + verticalSpacing
                currentLineHeight = 0

                offsets.append([])
                currentLine += 1
            }

            offsets[currentLine].append(CGRect(origin: currentPosition, size: size))

            currentPosition.x += size.width
            maximumLineWidth = max(maximumLineWidth, currentPosition.x)
            currentLineHeight = max(currentLineHeight, size.height)
            currentPosition.x += horizontalSpacing
        }

        return (CGSize(width: maximumLineWidth, height: currentPosition.y + currentLineHeight), offsets)
    }

    private func computeAlignmentOffsets(containerWidth: CGFloat, offsets: [[CGRect]]) -> [CGFloat] {
        guard alignment.horizontal != .leading else {
            return Array(repeating: 0, count: offsets.count)
        }

        var alignmentOffsets = [CGFloat]()
        for line in offsets {
            guard let lineWidth = line.last?.maxX else {
                alignmentOffsets.append(0)
                continue
            }

            switch alignment.horizontal {
            case .center:
                let offsetToCenter = (containerWidth - lineWidth) / 2
                alignmentOffsets.append(offsetToCenter)
            case .trailing:
                let offsetToTrailing = containerWidth - lineWidth
                alignmentOffsets.append(offsetToTrailing)
            default:
                alignmentOffsets.append(0)
            }
        }

        return alignmentOffsets
    }
}

@available(iOS 16.0, *)
#Preview {
    let count = 4
    let items = (
        Array(repeating: "abc", count: count) +
        Array(repeating: "abc-def", count: count) +
        Array(repeating: "abc-def-ghi", count: count)
    ).shuffled()

    VStack(spacing: 48) {
        FlowLayout(alignment: .leading, verticalSpacing: 8, horizontalSpacing: 8) {
            ForEach(items, id: \.self) { item in
                Text(item)
                    .padding(IKPadding.extraSmall)
                    .foregroundStyle(.white)
                    .background(Color.blue, in: .capsule)
            }
        }
        .border(.black)

        FlowLayout(alignment: .center, verticalSpacing: 8, horizontalSpacing: 8) {
            ForEach(items, id: \.self) { item in
                Text(item)
                    .padding(IKPadding.extraSmall)
                    .foregroundStyle(.white)
                    .background(Color.green, in: .capsule)
            }
        }
        .border(.black)

        FlowLayout(alignment: .trailing, verticalSpacing: 8, horizontalSpacing: 8) {
            ForEach(items, id: \.self) { item in
                Text(item)
                    .padding(IKPadding.extraSmall)
                    .foregroundStyle(.white)
                    .background(Color.red, in: .capsule)
            }
        }
        .border(.black)
    }
}

