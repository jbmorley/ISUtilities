ISUtilities
===========

Objective-C utility classes used in various InSeven Limited libraries and projects.

Classes
-------

### ISNotifier

A lightweight notificaion mechanism for observers for situations where NSNotificationCenter requires too much boiler-plate code or isn't explicit enough:

- Observers are added and removed with the `addObserver:` and `removeObserver:` methods.
- Notifications are dispatched to all observers which respond to a given selector using the `notify:withObject:withObject:...` methods.
- Observers are weakly referenced so it is not necessary to remove them when observers are released.


    #import <ISUtilities/ISNotifier.h>
    
    // Construct the notifier.
    ISNotifier *notifier = [ISNotifier new];

    // Add an observer.
    id anObserver = [... new];
    [notifier addObserver:anObserver];

    // Notifying all observers.
    [notifier notify:@selector(didUpdate:)
          withObject:self];

    // Remove the observer (optional)
    [notifier removeObserver:anObserver];

    

### ISDevice
### ISTableViewSubtitleCell
### NSDictionary+JSON
### NSObject+Serialize
### UIAlertView+Block
### UIApplication+Activity
### UIImage+Utilities
### UIView+Parent
