// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum CoreUILocalizable {
  /// loco:6729ea9f4cb9f889f604d934
  public static let buttonCancel = CoreUILocalizable.tr("Localizable", "buttonCancel", fallback: "Cancel")
  /// loco:675059634bdf0aedde06df72
  public static let buttonNext = CoreUILocalizable.tr("Localizable", "buttonNext", fallback: "Next")
  /// loco:6729ead76f93fd246802f932
  public static let buttonRetry = CoreUILocalizable.tr("Localizable", "buttonRetry", fallback: "Retry")
  /// loco:676538295907d1ab51014ae2
  public static let errorDownload = CoreUILocalizable.tr("Localizable", "errorDownload", fallback: "Download error")
  /// loco:67653882015fa8304b01cbb9
  public static let errorDownloadInsufficientSpace = CoreUILocalizable.tr("Localizable", "errorDownloadInsufficientSpace", fallback: "Cannot download : Insufficient space")
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
