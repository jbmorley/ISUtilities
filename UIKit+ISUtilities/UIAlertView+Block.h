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

typedef void (^ISAlertViewBlock)(NSUInteger buttonIndex);

@interface UIAlertView (Block) <UIAlertViewDelegate>

/**
 * Initialize a UIAlertView with a completion block to avoid the need to conform to the `UIAlertViewDelegate` protocol
 * and implementing `alertView:clickedButtonAtIndex:`.
 *
 * The completion block is always called on the main thread.
 * 
 * @param title The string that appears in the receiver’s title bar.
 * @param message Descriptive text that provides more details than the title.
 * @param block The completion block to be called when the `UIAlertView` is dismissed with a button tap.
 * @param cancelButtonTitle The title of the cancel button or nil if there is no cancel button. Using this argument is
 * equivalent to setting the cancel button index to the value returned by invoking `addButtonWithTitle:` specifying this
 * title.
 * @param otherButtonTitles The title of another button. Using this argument is equivalent to invoking
 * `addButtonWithTitle:` with this title to add more buttons. Too many buttons can cause the alert view to scroll. For
 * guidelines on the best ways to use an alert in an app, see Temporary Views.
 * @param ... Titles of additional buttons to add to the receiver, terminated with `nil`.
 *
 * @return Newly initialized alert view.
 */
- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
              completionBlock:(void (^)(NSUInteger buttonIndex))block
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ...;

@end