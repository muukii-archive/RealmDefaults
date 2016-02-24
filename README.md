# RealmDefaults

[![CI Status](http://img.shields.io/travis/muukii/RealmDefaults.svg?style=flat)](https://travis-ci.org/muukii/RealmDefaults)
[![Version](https://img.shields.io/cocoapods/v/RealmDefaults.svg?style=flat)](http://cocoapods.org/pods/RealmDefaults)
[![License](https://img.shields.io/cocoapods/l/RealmDefaults.svg?style=flat)](http://cocoapods.org/pods/RealmDefaults)
[![Platform](https://img.shields.io/cocoapods/p/RealmDefaults.svg?style=flat)](http://cocoapods.org/pods/RealmDefaults)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

RealmDefaults is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "RealmDefaults"
```

## Usage

```swift
public class RealmDefaults : RealmSwift.Object {

    public class func purge()

    public class func schemaVersion() -> UInt64

    public class func defaultsName() -> String

    public class func filePath() -> String

    public class func configuration() -> RealmSwift.Realm.Configuration
}
```

### Create subclass of RealmDefaults.

```swift
import RealmDefaults

class MyAccount: RealmDefaults {

    dynamic var name: String?
    dynamic var age: Int = 0
    dynamic var phoneNumber: String?

    override class func schemaVersion() -> UInt64 {
        return 3
    }
}
```

### Read & Write

```swift
MyAccount.write { account in
    account.name = "muukii"
    account.age = 25
    account.phoneNumber = "080-0000-0000"
}

print(MyAccount.instance.name) // -> muukii
print(MyAccount.instance.age) // 25
print(MyAccount.instance.phoneNumber) // 080-0000-0000
```

## Author

muukii, m@muukii.me

## License

RealmDefaults is available under the MIT license. See the LICENSE file for more info.
