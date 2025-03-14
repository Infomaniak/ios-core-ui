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

import DesignSystem
import SwiftUI

struct FlowLine: Sendable {
    let offsets: [CGRect]
    let sizes: [CGSize]
    let height: CGFloat

    let count: Int

    init(offsets: [CGRect], sizes: [CGSize], lineHeight: CGFloat) {
        self.offsets = offsets
        self.sizes = sizes
        height = lineHeight

        count = max(offsets.count, sizes.count)
    }
}

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
        let (size, flowLines) = computeLayout(proposal: proposal, subviews: subviews)
        let alignmentOffsets = computeHorizontalAlignmentOffsets(containerWidth: size.width, lines: flowLines)

        var subviewIndex = 0
        for lineNumber in flowLines.indices {
            let flowLine = flowLines[lineNumber]
            for indexInLine in 0 ..< flowLine.count {
                let subview = subviews[subviewIndex]

                let offset = flowLine.offsets[indexInLine]
                let viewSize = flowLine.sizes[indexInLine]

                subview.place(
                    at: CGPoint(
                        x: bounds.minX + offset.minX + alignmentOffsets[lineNumber],
                        y: bounds.minY + offset.minY + computeVerticalAlignmentOffset(for: viewSize, in: flowLine)
                    ),
                    proposal: ProposedViewSize(viewSize)
                )

                subviewIndex += 1
            }
        }
    }

    private func computeLayout(proposal: ProposedViewSize, subviews: Subviews) -> (CGSize, [FlowLine]) {
        let availableSize = CGSize(width: proposal.width ?? .infinity, height: proposal.height ?? .infinity)

        var flowLines = [FlowLine]()

        var proposedViewSizes = [CGSize]()
        var offsets = [CGRect]()

        var currentPosition = CGPoint.zero
        var maximumLineWidth = CGFloat.zero
        var currentLineHeight = CGFloat.zero

        for subview in subviews {
            var (idealSize, fittingSize) = computeSubviewSizes(in: availableSize, for: subview, at: currentPosition)

            let isFirstChipOfLine = currentPosition.x == 0
            let isIdealSizeLargerThanFitting = idealSize.width > fittingSize.width
            let isAvailableSpaceTooSmall = currentPosition.x + fittingSize.width > availableSize.width
            if !isFirstChipOfLine && (isIdealSizeLargerThanFitting || isAvailableSpaceTooSmall) {
                flowLines.append(FlowLine(offsets: offsets, sizes: proposedViewSizes, lineHeight: currentLineHeight))

                currentPosition.x = 0
                currentPosition.y += currentLineHeight + verticalSpacing

                proposedViewSizes = []
                offsets = []
                currentLineHeight = 0

                (_, fittingSize) = computeSubviewSizes(in: availableSize, for: subview, at: currentPosition)
            }

            proposedViewSizes.append(fittingSize)
            offsets.append(CGRect(origin: currentPosition, size: fittingSize))

            currentPosition.x += fittingSize.width
            maximumLineWidth = max(maximumLineWidth, currentPosition.x)
            currentLineHeight = max(currentLineHeight, fittingSize.height)
            currentPosition.x += horizontalSpacing
        }
        flowLines.append(FlowLine(offsets: offsets, sizes: proposedViewSizes, lineHeight: currentLineHeight))

        return (CGSize(width: maximumLineWidth, height: currentPosition.y + currentLineHeight), flowLines)
    }

    private func computeSubviewSizes(in size: CGSize, for view: LayoutSubview, at currentPosition: CGPoint) -> (CGSize, CGSize) {
        let remainingSize = CGSize(width: size.width - currentPosition.x, height: size.height - currentPosition.y)

        let idealSize = view.sizeThatFits(.unspecified)
        let fittingSize = view.sizeThatFits(ProposedViewSize(remainingSize))
        return (idealSize, fittingSize)
    }

    private func computeHorizontalAlignmentOffsets(containerWidth: CGFloat, lines: [FlowLine]) -> [CGFloat] {
        guard alignment.horizontal != .leading else {
            return Array(repeating: 0, count: lines.count)
        }

        var alignmentOffsets = [CGFloat]()
        for line in lines {
            guard let lineWidth = line.offsets.last?.maxX else {
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

    private func computeVerticalAlignmentOffset(for size: CGSize, in line: FlowLine) -> CGFloat {
        switch alignment.vertical {
        case .center:
            return (line.height - size.height) / 2
        case .bottom:
            return line.height - size.height
        default:
            return 0
        }
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

    VStack(spacing: IKPadding.huge) {
        FlowLayout(alignment: Alignment(horizontal: .leading, vertical: .center), verticalSpacing: 8, horizontalSpacing: 8) {
            ForEach(items, id: \.self) { item in
                Text(item)
                    .padding(IKPadding.micro)
                    .foregroundStyle(.white)
                    .background(Color.blue, in: .capsule)
            }
        }
        .border(.black)

        FlowLayout(alignment: Alignment(horizontal: .center, vertical: .top), verticalSpacing: 8, horizontalSpacing: 8) {
            ForEach(items, id: \.self) { item in
                Text(item)
                    .font([Font.headline, Font.body, Font.caption2].randomElement()!)
                    .padding(IKPadding.micro)
                    .foregroundStyle(.white)
                    .background(Color.green, in: .capsule)
            }
        }
        .border(.black)

        FlowLayout(alignment: Alignment(horizontal: .center, vertical: .center), verticalSpacing: 8, horizontalSpacing: 8) {
            ForEach(items, id: \.self) { item in
                Text(item)
                    .font([Font.headline, Font.body, Font.caption2].randomElement()!)
                    .padding(IKPadding.micro)
                    .foregroundStyle(.white)
                    .background(Color.green, in: .capsule)
            }
        }
        .border(.black)

        FlowLayout(alignment: Alignment(horizontal: .center, vertical: .bottom), verticalSpacing: 8, horizontalSpacing: 8) {
            ForEach(items, id: \.self) { item in
                Text(item)
                    .font([Font.headline, Font.body, Font.caption2].randomElement()!)
                    .padding(IKPadding.micro)
                    .foregroundStyle(.white)
                    .background(Color.green, in: .capsule)
            }
        }
        .border(.black)

        FlowLayout(alignment: Alignment(horizontal: .trailing, vertical: .center), verticalSpacing: 8, horizontalSpacing: 8) {
            ForEach(items, id: \.self) { item in
                Text(item)
                    .padding(IKPadding.micro)
                    .foregroundStyle(.white)
                    .background(Color.red, in: .capsule)
            }
        }
        .border(.black)
    }
}
