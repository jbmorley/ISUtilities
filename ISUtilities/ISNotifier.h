//
// Copyright (c) 2013-2014 InSeven Limited.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

#import <Foundation/Foundation.h>

/**
 * A lightweight notificaion mechanism for observers for situations where NSNotificationCenter requires too much
 * boiler-plate code or isn't explicit enough:
 *
 *
 * ```
 * #import <ISUtilities/ISUtilities.h>
 *
 * // Construct the notifier.
 * ISNotifier *notifier = [ISNotifier new];
 *
 * // Add an observer.
 * id anObserver = [YourCustomClass new];
 * [notifier addObserver:anObserver];
 *
 * // Notifying all observers.
 * [notifier notify:@selector(didUpdate:) withObject:self];
 *
 * // Remove the observer (optional).
 * [notifier removeObserver:anObserver];
 * ```
 *
 * Notes:
 *
 * - Observers are weakly referenced so it is not necessary to remove them when observers are released.
 * - Notifications are dispatched to all observers which respond to a given selector using the
 *   `notify:withObject:withObject:...` methods.
 * - Notifications are called on the same thread as the call to `notify:`, `notify:withObject:`, etc.
 * - It is recommended that you wrap the calls to `addObserver:` and `removeObserver:` with ones which enforce a
 *   protocol to avoid adding the wrong type of class or simply failing to implement one of your observer selectors.
 * - ISNotifier is not thread-safe with one exception: observers can be safely released on any thread.
 */
@interface ISNotifier : NSObject

@property (nonatomic, readonly) NSUInteger count;

/**
 * Add an observer.
 * 
 * The observer is weakly referenced and not retained.
 *
 * @param observer The observer to add.
 */
- (void)addObserver:(id)observer;

/**
 * Remove an observer.
 *
 * @param observer The observer to remove.
 */
- (void)removeObserver:(id)observer;

- (void)notify:(SEL)selector;
- (void)notify:(SEL)selector
    withObject:(id)anObject;
- (void)notify:(SEL)selector
    withObject:(id)anObject
    withObject:(id)anotherObject;
- (void)notify:(SEL)selector
    withObject:(id)anObject
    withObject:(id)anotherObject
    withObject:(id)yetAnotherObject;

@end
