ISUtilities
===========

Objective-C utility classes used in various InSeven Limited libraries and projects.

Installation
------------

ISUtilities is available through [CocoaPods](http://cocoapods.org/):

```
platform: ios, '6.0'
pod "ISUtilities", "~> 1.1"
```

Documentation
-------------

Compiled documentation is available on [CocoaDocs](http://cocoadocs.org/docsets/ISUtilities/).

Documentation can be built locally using `appledoc` by executing the following command from the root of the repository:

```
./Scripts/build-docs.sh
```

Tests
-----

Tests can be run by executing the following command from the root of the repository:

```
./Scripts/run-tests.sh
```

### NSDictionary+JSON

JSON serialization and de-serialization category for NSDictionary:

```objc
#import <ISUtilities/ISUtilities.h>

// Serialization.
NSDictionary *outDict = @{@"title": @"cheese"};
NSString *json = [outDict JSON];
NSLog(@"%@", json); // {"title": "cheese"}

// De-serialization.
NSDictionary *inDict = [NSDictionary dictionaryWithJSON:json];
NSLog(@"Title: %@", outDict[@"title"]); // Title: cheese
```


### NSObject+Serialize

Category for checking whether an NSObject can be serialized using the `writeToFile:atomically:` and `writeToURL:atomically:` methods:

```objc
#import <ISUtilities/ISUtilities.h>

// Dictionary containing safe objects.
NSDictionary *valid = @{@"items": @[@"one", @"two", @"three"]};
BOOL checkValid = [valid canWriteToFile]; // YES

// Dictionary containing unsafe objects.
NSArry *invalid = @[[YourCustomClass new], [YourCustomClass new]];
BOOL checkInvalid = [invalid canWriteToFile]; // NO
```

This can prove userful if it is necessary to ensure that an NSDictionary or NSArray and its contents can be safely stored to file. It works by validating that every object is an instance of `NSData`, `NSDate`, `NSNumber`, `NSString`, `NSArray`, or `NSDictionary` (as described in the documentation for `NSArray`  and `NSDictionary`).


### UIAlertView+Block

Initialize a UIAlertView with a completion block to avoid the need to conform to the `UIAlertViewDelegate` protocol and implementing `alertView:clickedButtonAtIndex:`:

```objc
#import <ISUtilities/UIKit+ISUtilities.h>

// Create the UIAlertView.
UIAlertView *alertView =
[[UIAlertView alloc] initWithTitle:@"Alert"
                         message:@"Click a button..."
                 completionBlock:^(NSUInteger buttonIndex) {
                                   if (buttonIndex == 0) {
                                     // Cancel...
                                   } else if (buttonIndex == 1) {
                                     // One...
                                   } else if (buttonIndex == 2) {
                                     // Two...
                                   }
                                 }
               cancelButtonTitle:@"Cancel"
               otherButtonTitles:@"One", @"Two", nil];

// Show the alert view.
[alertView show];
```

Changelog
---------

### Version 1.1.0

- Adding appledoc.
- Adding unit tests.
- Changing the internal directory structure to make it easier to include without CocoaPods.
- Separating UIKit and CoreFoundation libraries into separate headers.
- Adding support for OS X targets.
- FIX: Fixing thread safety issues in `ISWeakReferenceArray` when references are freed on during enumeration.

### Version 1.0.1

- FIX: Support for `nil` blocks in UIAlertView+Block.

### Version 1.0.0

- Initial release.

License
-------

ISUtilities is available under the MIT license. See the LICENSE file for more info.
