ISUtilities
===========

Objective-C utility classes used in various InSeven Limited libraries and projects.

Classes
-------

### ISNotifier

A lightweight notificaion mechanism for observers for situations where NSNotificationCenter requires too much boiler-plate code or isn't explicit enough:


```objc
#import <ISUtilities/ISNotifier.h>
    
// Construct the notifier.
ISNotifier *notifier = [ISNotifier new];

// Add an observer.
id anObserver = [YourCustomClass new];
[notifier addObserver:anObserver];

// Notifying all observers.
[notifier notify:@selector(didUpdate:) 
      withObject:self];

// Remove the observer (optional)
[notifier removeObserver:anObserver];
```

Notes:

- Observers are added and removed with the `addObserver:` and `removeObserver:` methods.
- Observers are weakly referenced so it is not necessary to remove them when observers are released.
- Notifications are dispatched to all observers which respond to a given selector using the `notify:withObject:withObject:...` methods. 
- It is recommended that you wrap the calls to `addObserver:` and `removeObserver:` with ones which enforce a protocol to avoid adding the wrong type of class or simply failing to implement one of your observer selectors.


### NSDictionary+JSON

JSON serialization and de-serialization category for NSDictionary:

```objc
#import <ISUtilities/NSDictionary+JSON.h>

// Serialization.
NSDictionary *outDict = @{@"title": @"cheese"};
NSString *json = [outDict JSON];
NSLog(@"%@", json); // {"title": "cheese"}

// De-serialization.
NSDictionary *inDict = [NSDictionary dictionaryWithJSON:json];
NSLog(@"Title: %@", outDict[@"title"]); // Title: cheese
```


### NSObject+Serialize
### UIAlertView+Block
### UIApplication+Activity
### UIImage+Utilities
### UIView+Parent
