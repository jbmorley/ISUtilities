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

#import <UIKit/UIKit.h>

/**
 * Thread-safe category for managing the UIApplication idle timer.
 */
@interface UIApplication (IdleTimer)

/**
 * Disable the idle timer.
 * 
 * Internally this keeps a count of the number of calls to `disableIdleTimer` and `enableIdleTimer` and disables
 * the application idle timer when there is one-or-more active request to disable the timer.
 * 
 * Thread-safe.
 */
- (void)disableIdleTimer;

/**
 * Enable the idle timer.
 *
 * Internally this keeps a count of the number of calls to `disableIdleTimer` and `enableIdleTimer` and only re-enables
 * the application idle timer when there are no active requests to disable the timer.
 * 
 * Thread-safe.
 */
- (void)enableIdleTimer;

@end
