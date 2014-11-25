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

#import "ISUtilities.h"

void ISAssert(BOOL condition, NSString *desc, ...)
{
    if (!condition) {
        va_list args;
        va_start(args, desc);
        NSLogv(desc, args);
        va_end(args);
        assert(false);
    }
}

void ISAssertUnreached(NSString *message, ...)
{
    va_list args;
    va_start(args, message);
    NSLogv(message, args);
    va_end(args);
    assert(false);
}

dispatch_queue_t ISDispatchQueueCreate(NSString *domain, id instance, NSString *name, dispatch_queue_attr_t attr)
{
    NSString *label = [NSString stringWithFormat:
                       @"%@.%@.%p.%@",
                       domain,
                       NSStringFromClass([instance class]),
                       instance,
                       name];
    return dispatch_queue_create([label UTF8String], attr);
}

void ISSafeSetDictionaryKey(NSMutableDictionary *dictionary, id key, id value)
{
    if (value) {
        dictionary[key] = value;
    }
}
