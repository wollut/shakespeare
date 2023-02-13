# Shakespeare

Simplify work with `OSLog` withing Swift

## Installation
```swift
.package(
    url: "https://github.com/wollut/shakespeare.git",
    .upToNextMajor(from: "0.1.0")
)
```

## Usage
```swift
import Shakespeare

extension Shakespeare.Category {
    static let resources = Shakespeare.Category(category: "resources")
}

private extension Shakespeare.Category {
    init(category: String) {
        self.init(subsystem: "com.wollut.application", category: category)
    }
}

log(category: .resources, kind: .fault, "Can't locate color named '\(name)'")
```

## Authors
- anton@wollut.com
