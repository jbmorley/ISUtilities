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

#import "ISNotifier.h"
#import "ISWeakReference.h"
#import "ISWeakReferenceArray.h"
#import "NSDictionary+JSON.h"
#import "NSObject+Serialize.h"
#import "NSObject+Threads.h"
#import "ISCancelable.h"
#import "ISCancelToken.h"

void ISAssert(BOOL condition, NSString *desc, ...);

void ISAssertUnreached(NSString *message, ...);

/**
 * Create a dispatch queue with a custom identifier including domain, class name, class instance and instance name.
 *
 * Example usage:
 * ```
 * dispatch_queue_t completionQueue = ISDispatchQueueCreate(@"uk.co.inseven",
 *                                                          self,
 *                                                          @"completionQueue",
 *                                                          DISPATCH_QUEUE_CONCURRENT);
 * ```
 *
 * @param domain Reverse-DNS domain.
 * @param instance Class instance of which the queue is a member.
 * @param name Instance name (e.g. the queue member variable name).
 * @param attr Dispatch queue attributes (see `dispatch_queue_create`).
 *
 * @return The newly created dispatch queue.
 */
dispatch_queue_t ISDispatchQueueCreate(NSString *domain, id instance, NSString *name, dispatch_queue_attr_t attr);

void ISSafeSetDictionaryKey(NSMutableDictionary *dictionary, id key, id value);
