//
//  Created by Anton Spivak
//

// MARK: - TerminalColor

internal enum TerminalColor: String {
    case black = "\u{001B}[0;30m"
    case red = "\u{001B}[0;31m"
    case green = "\u{001B}[0;32m"
    case yellow = "\u{001B}[0;33m"
    case blue = "\u{001B}[0;34m"
    case magenta = "\u{001B}[0;35m"
    case cyan = "\u{001B}[0;36m"
    case white = "\u{001B}[0;37m"
    case `default` = "\u{001B}[0;0m"
}

internal extension String {
    func wrapped(withColor color: TerminalColor) -> Self {
        "\(color.rawValue)\(self)\(TerminalColor.default.rawValue)"
    }

    mutating func wrap(withColor color: TerminalColor) {
        self = wrapped(withColor: color)
    }
}
