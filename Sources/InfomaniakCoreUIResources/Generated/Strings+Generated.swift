// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum CoreUILocalizable {
  /// loco:675fea0d40923b5c440f0f52
  public static let anErrorHasOccurred = CoreUILocalizable.tr("Localizable", "anErrorHasOccurred", fallback: "An error has occurred")
  /// loco:6729ea9f4cb9f889f604d934
  public static let buttonCancel = CoreUILocalizable.tr("Localizable", "buttonCancel", fallback: "Cancel")
  /// loco:67ac7d178defcfcd7806e182
  public static let buttonLater = CoreUILocalizable.tr("Localizable", "buttonLater", fallback: "Later")
  /// loco:675059634bdf0aedde06df72
  public static let buttonNext = CoreUILocalizable.tr("Localizable", "buttonNext", fallback: "Next")
  /// loco:67beed573c592678eb085582
  public static let buttonNo = CoreUILocalizable.tr("Localizable", "buttonNo", fallback: "No")
  /// loco:6729ead76f93fd246802f932
  public static let buttonRetry = CoreUILocalizable.tr("Localizable", "buttonRetry", fallback: "Retry")
  /// loco:682dc3dd2d87d3cbda04b3a2
  public static let buttonSave = CoreUILocalizable.tr("Localizable", "buttonSave", fallback: "Save")
  /// loco:685d08b2fc3b99693f00c872
  public static let buttonUploadFromCamera = CoreUILocalizable.tr("Localizable", "buttonUploadFromCamera", fallback: "Camera")
  /// loco:685d0914ecd5fc13620f1fc2
  public static let buttonUploadFromFiles = CoreUILocalizable.tr("Localizable", "buttonUploadFromFiles", fallback: "Browse files")
  /// loco:685d08dc653f4deb94019b62
  public static let buttonUploadFromGallery = CoreUILocalizable.tr("Localizable", "buttonUploadFromGallery", fallback: "Photo and video gallery")
  /// loco:67beed7f8291a886220faf53
  public static let buttonYes = CoreUILocalizable.tr("Localizable", "buttonYes", fallback: "Yes")
  /// loco:676538295907d1ab51014ae2
  public static let errorDownload = CoreUILocalizable.tr("Localizable", "errorDownload", fallback: "Download error")
  /// loco:67653882015fa8304b01cbb9
  public static let errorDownloadInsufficientSpace = CoreUILocalizable.tr("Localizable", "errorDownloadInsufficientSpace", fallback: "Cannot download: Insufficient space")
  /// loco:67dbc1f28c22b8594f030f32
  public static let joinTheBetaButton = CoreUILocalizable.tr("Localizable", "joinTheBetaButton", fallback: "Join the beta program")
  /// loco:67beee584d2044470e0df152
  public static func reviewAlertTitle(_ p1: Any) -> String {
    return CoreUILocalizable.tr("Localizable", "reviewAlertTitle", String(describing: p1), fallback: "Do you like %@?")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension CoreUILocalizable {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
