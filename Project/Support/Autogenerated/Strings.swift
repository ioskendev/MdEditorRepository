// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable all

internal enum L10n {

  internal enum LoginScreen {
    /// Authorization
    internal static let title = L10n.tr("Localizable", "LoginScreen.Title")

    internal enum Button {

      internal enum Login {
        /// Login
        internal static let title = L10n.tr("Localizable", "LoginScreen.Button.Login.Title")
      }
    }

    internal enum Textfield {

      internal enum Login {
        /// Login
        internal static let placeholder = L10n.tr("Localizable", "LoginScreen.Textfield.Login.Placeholder")
      }

      internal enum Password {
        /// Login
        internal static let placeholder = L10n.tr("Localizable", "LoginScreen.Textfield.Password.Placeholder")
      }
    }
  }

  internal enum TodoListScreen {
    /// ToDoList
    internal static let title = L10n.tr("Localizable", "TodoListScreen.Title")
  }
}

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
// swiftlint:enable all