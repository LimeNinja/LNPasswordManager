# LNPasswordManager

[![CI Status](http://img.shields.io/travis/NilSkilz/LNPasswordManager.svg?style=flat)](https://travis-ci.org/NilSkilz/LNPasswordManager)
[![Version](https://img.shields.io/cocoapods/v/LNPasswordManager.svg?style=flat)](http://cocoadocs.org/docsets/LNPasswordManager)
[![License](https://img.shields.io/cocoapods/l/LNPasswordManager.svg?style=flat)](http://cocoadocs.org/docsets/LNPasswordManager)
[![Platform](https://img.shields.io/cocoapods/p/LNPasswordManager.svg?style=flat)](http://cocoadocs.org/docsets/LNPasswordManager)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

LNPasswordManager provides some helper classes to save and verify passwords

First, reference the singleton class:
```ObjectiveC
    LNPasswordManager *manager = [LNPasswordManager defaultKeychain];
```

The following are optional implementations
```ObjectiveC
    [manager setICloudSyncEnabled:YES]; // Enables syncing of the keychain with iCloud
    [manager setServiceName:@"com.limeninja.appName"]; // Sets the service name
```

To save and verify passwords use:
```ObjectiveC
    [manager savePassword:passwordField.text forUsername:usernameField.text];
    
    if ([manager verifyPassword:passwordField.text forUsername:usernameField.text]) {
        NSLog(@"Password Correct");
    } else {
        NSLog(@"Password Incorrect");
    }
```

## Additional Usage

You can use LNPasswordManager to store other key/value pairs in the keychain using the following methods

```ObjectiveC
    [manager getKeychainValueForKey:@"Key"]; // Returns NSData
    [manager createKeychainValue@"Value" forKey:@"Key"]; // Returns a BOOL
    [manager updateKeychainValue:@"Value" forKey:@"Key"]; // Returns a BOOL
    [manager deleteKeychainValue:@"Key"];
```

## Installation

LNPasswordManager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "LNPasswordManager"

## Author

NilSkilz, rob.stokes@redsource.com

## License

LNPasswordManager is available under the MIT license. See the LICENSE file for more info.

