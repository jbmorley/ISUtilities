//
//  ISUtilities.m
//  Pods
//
//  Created by Jason Barrie Morley on 25/11/2014.
//
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
