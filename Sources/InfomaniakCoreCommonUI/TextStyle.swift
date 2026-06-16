#if canImport(UIKit)
import UIKit

public typealias PlatformFont = UIFont
public typealias PlatformColor = UIColor
#elseif canImport(AppKit)
import AppKit

public typealias PlatformFont = NSFont
public typealias PlatformColor = NSColor
#endif

public struct TextStyle: RawRepresentable {
    public var font: PlatformFont
    public var color: PlatformColor

    public static let header1 = TextStyle(
        font: .platformSystemFont(ofSize: 28, weight: .bold),
        color: .platformTitleColor,
        rawValue: "header1"
    )
    public static let header2 = TextStyle(
        font: .platformSystemFont(ofSize: 18, weight: .semibold),
        color: .platformTitleColor,
        rawValue: "header2"
    )
    public static let header3 = TextStyle(
        font: .platformSystemFont(ofSize: 16, weight: .semibold),
        color: .platformTitleColor,
        rawValue: "header3"
    )
    public static let subtitle1 = TextStyle(
        font: .platformSystemFont(ofSize: 16, weight: .regular),
        color: .platformTitleColor,
        rawValue: "subtitle1"
    )
    public static let subtitle2 = TextStyle(
        font: .platformSystemFont(ofSize: 14, weight: .medium),
        color: .platformTitleColor,
        rawValue: "subtitle2"
    )
    public static let body1 = TextStyle(
        font: .platformSystemFont(ofSize: 14, weight: .regular),
        color: .platformTitleColor,
        rawValue: "body1"
    )
    public static let body2 = TextStyle(
        font: .platformSystemFont(ofSize: 14, weight: .regular),
        color: .platformPrimaryTextColor,
        rawValue: "body2"
    )
    public static let caption = TextStyle(
        font: .platformSystemFont(ofSize: 12, weight: .regular),
        color: .platformPrimaryTextColor,
        rawValue: "caption"
    )
    public static let header1Light = TextStyle(
        font: .platformSystemFont(ofSize: 28, weight: .bold),
        color: .white,
        rawValue: "header1Light"
    )
    public static let captionLight = TextStyle(
        font: .platformSystemFont(ofSize: 12, weight: .regular),
        color: .white,
        rawValue: "captionLight"
    )
    public static let body1Light = TextStyle(
        font: .platformSystemFont(ofSize: 14, weight: .regular),
        color: .white,
        rawValue: "body1Light"
    )
    public static let action = TextStyle(
        font: .platformSystemFont(ofSize: 14, weight: .regular),
        color: .platformInfomaniakColor,
        rawValue: "action"
    )

    static let allValues = [
        header1,
        header2,
        header3,
        subtitle1,
        subtitle2,
        body1,
        body2,
        caption,
        header1Light,
        captionLight,
        body1Light,
        action
    ]

    public typealias RawValue = String
    public var rawValue: String

    init(font: PlatformFont, color: PlatformColor, rawValue: RawValue) {
        self.font = font
        self.color = color
        self.rawValue = rawValue
    }

    public init?(rawValue: String) {
        guard let style = TextStyle.allValues.first(where: { $0.rawValue == rawValue }) else {
            return nil
        }
        self = style
    }
}

#if canImport(UIKit)
private extension UIFont {
    static func platformSystemFont(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        systemFont(ofSize: UIFontMetrics.default.scaledValue(for: size), weight: weight)
    }
}

private extension UIColor {
    static var platformTitleColor: UIColor {
        InfomaniakCoreAsset.titleColor.color
    }

    static var platformPrimaryTextColor: UIColor {
        InfomaniakCoreAsset.primaryTextColor.color
    }

    static var platformInfomaniakColor: UIColor {
        InfomaniakCoreAsset.infomaniakColor.color
    }
}

#elseif canImport(AppKit)
private extension NSFont {
    static func platformSystemFont(ofSize size: CGFloat, weight: NSFont.Weight) -> NSFont {
        systemFont(ofSize: size, weight: weight)
    }
}

private extension NSColor {
    static var platformTitleColor: NSColor {
        InfomaniakCoreAsset.titleColor.color
    }

    static var platformPrimaryTextColor: NSColor {
        InfomaniakCoreAsset.primaryTextColor.color
    }

    static var platformInfomaniakColor: NSColor {
        InfomaniakCoreAsset.infomaniakColor.color
    }
}
#endif
