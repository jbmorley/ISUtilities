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

#import "ISNotifier.h"
#import "ISWeakReference.h"
#import "ISWeakReferenceArray.h"

@interface ISNotifier ()
@property (strong, nonatomic) ISWeakReferenceArray *observers;
@end

@implementation ISNotifier

- (id)init
{
    self = [super init];
    if (self) {
        self.observers = [ISWeakReferenceArray arrayWithCapacity:3];
    }
    return self;
}

- (NSUInteger)count
{
    return self.observers.count;
}

- (void)addObserver:(id)observer
{
    if (![self.observers containsObject:observer]) {
        [self.observers addObject:observer];
    }
}

- (void)removeObserver:(id)observer
{
    [self.observers removeObject:observer];
}

- (void)notify:(SEL)selector
{
    NSParameterAssert(selector);
    
    [self.observers enumerateObjectsUsingBlock:^(id object, __unused NSUInteger idx, __unused BOOL *stop) {
        if ([object respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [object performSelector:selector];
#pragma clang diagnostic pop
        }
    }];
}

- (void)notify:(SEL)selector
    withObject:(id)anObject
{
    NSParameterAssert(selector);
    
    [self.observers enumerateObjectsUsingBlock:^(id object, __unused NSUInteger idx, __unused BOOL *stop) {
        if ([object respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [object performSelector:selector
                         withObject:anObject];
#pragma clang diagnostic pop
        }
    }];
}

- (void)notify:(SEL)selector
    withObject:(id)anObject
    withObject:(id)anotherObject
{
    NSParameterAssert(selector);
    
    [self.observers enumerateObjectsUsingBlock:^(id object, __unused NSUInteger idx, __unused BOOL *stop) {
        if ([object respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [object performSelector:selector
                         withObject:anObject
                         withObject:anotherObject];
#pragma clang diagnostic pop
        }
    }];
}

- (void)notify:(SEL)selector
    withObject:(id)anObject
    withObject:(id)anotherObject
    withObject:(id)yetAnotherObject
{
    NSParameterAssert(selector);
    
    __strong id *anObjectP = &anObject;
    __strong id *anotherObjectP = &anotherObject;
    __strong id *yetAnotherObjectP = &yetAnotherObject;
    [self.observers enumerateObjectsUsingBlock:^(id object, __unused NSUInteger idx, __unused BOOL *stop) {
        if ([object respondsToSelector:selector]) {
            
            // Construct an NSInvocation for the selector.
            NSMethodSignature *methodSignature = [object methodSignatureForSelector:selector];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
            [invocation setTarget:object];
            [invocation setSelector:selector];
            [invocation setArgument:anObjectP
                            atIndex:2];
            [invocation setArgument:anotherObjectP
                            atIndex:3];
            [invocation setArgument:yetAnotherObjectP
                            atIndex:4];
            [invocation invoke];
        }
    }];
}

@end
