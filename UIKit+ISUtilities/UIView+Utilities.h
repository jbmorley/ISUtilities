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

@interface UIView (Parent)

/**
 * Determines the current UIView or any of its subviews i the current first responder.
 *
 * @return YES if the UIView or any of its subviews is the current first responder. NO otherwise.
 */
- (BOOL)containsCurrentFirstResponder;

/**
 * Resigns the first responder for the  UIView and any of its subviews.
 *
 * @param YES if a first responder was found and successfully resigned. NO otherwise.
 */
- (BOOL)resignCurrentFirstResponder;

/**
 * Determines if the current UIView contains any subviews of a given class.
 *
 * @param class The class to check for.
 *
 * @return YES if there is one-or-more subviews of Class `class`. NO otherwise.
 */
- (BOOL)hasSuperviewOfKindOfClass:(Class)class;

@end
