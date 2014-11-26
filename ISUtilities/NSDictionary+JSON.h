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
 * JSON serialization and de-serialization category for NSDictionary.
 */
@interface NSDictionary (JSON)

/**
 * Deserialize an NSDictionary from a string containing JSON.
 * 
 * @param JSON String containing JSON.
 * @param error If an error occurs, upon return contains an NSError object that describes the problem.
 *
 * @return Newly created `NSDictionary` containing containing the JSON data. `nil` if it was not possible to decode the
 * JSON.
 */
+ (NSDictionary *)dictionaryWithJSON:(NSString *)JSON error:(NSError **)error;

/**
 * Serialize an NSDictionary as a JSON string.
 *
 * @return String containing JSON representation of the dictionary.
 */
- (NSString *)JSON;

@end
