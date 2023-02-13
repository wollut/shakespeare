//
//  Created by Anton Spivak
//

import OSLog

// MARK: - Shakespeare

public enum Shakespeare {}

public func log(
    category: Shakespeare.Category,
    kind: Shakespeare.Kind = .default,
    _ items: Any...,
    separator: String = " ",
    terminator: String = "\n"
) {
    let string = items.map({ "\($0)" }).joined(separator: separator) + terminator
    category.rawLogger.log(level: kind.rawType, "\(string)")

    switch kind {
    case .debug, .default:
        print(string, to: &Shakespeare.standardOutput)
    case .info:
        print(string.wrapped(withColor: .green), to: &Shakespeare.standardOutput)
    case .error:
        print(string.wrapped(withColor: .red), to: &Shakespeare.standardError)
    case .fault:
        print(string.wrapped(withColor: .magenta), to: &Shakespeare.standardError)
    default:
        print(string, to: &Shakespeare.standardOutput)
    }
}

// MARK: Shakespeare.Kind

public extension Shakespeare {
    struct Kind {
        // MARK: Lifecycle

        internal init(_ rawType: OSLogType) {
            self.rawType = rawType
        }

        // MARK: Internal

        internal let rawType: OSLogType
    }
}

public extension Shakespeare.Kind {
    static let `default` = Shakespeare.Kind(.default)
    static let info = Shakespeare.Kind(.info)
    static let debug = Shakespeare.Kind(.debug)
    static let error = Shakespeare.Kind(.error)
    static let fault = Shakespeare.Kind(.fault)
}

// MARK: - Shakespeare.Kind + Equatable

extension Shakespeare.Kind: Equatable {}

// MARK: - Shakespeare.Category

public extension Shakespeare {
    struct Category {
        // MARK: Lifecycle

        public init(subsystem: String, category: String) {
            self.rawLogger = Logger(subsystem: subsystem, category: category)
        }

        // MARK: Internal

        let rawLogger: Logger
    }
}

// MARK: Shakespeare.StandardError

private extension Shakespeare {
    struct StandardError: TextOutputStream {
        mutating func write(_ string: String) {
            for byte in string.utf8 { putc(numericCast(byte), stderr) }
        }
    }

    static var standardError = StandardError()
}

// MARK: Shakespeare.StandardOutput

private extension Shakespeare {
    struct StandardOutput: TextOutputStream {
        mutating func write(_ string: String) {
            for byte in string.utf8 { putc(numericCast(byte), stdout) }
        }
    }

    static var standardOutput = StandardOutput()
}
