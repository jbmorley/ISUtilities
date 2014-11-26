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

Changelog
---------

### Version 1.1.2

- Exposing the error when decoding JSON in the `NSDictionary+JSON` category.
- Adding unit tests for JSON encoding and decoding.

### Version 1.1.1

- Minor tweaks and documentation improvements.

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
