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
 * Category for checking whether an NSObject can be serialized to file.
 */
@interface NSObject (Serialize)

/**
 * Determines if an object can be serialized to file using the `writeToFile:atomically:` and `writeToURL:atomically:`
 * methods.
 *
 * This can prove userful if it is necessary to ensure that an NSDictionary or NSArray and its contents can be safely
 * stored to file. It works by validating that every object is an instance of `NSData`, `NSDate`, `NSNumber`,
 * `NSString`, `NSArray`, or `NSDictionary` (as described in the documentation for `NSArray`  and `NSDictionary`).
 *
 * @return YES if the object can be serialized to a file. NO otherwise.
 */
- (BOOL)canWriteToFile;

@end
