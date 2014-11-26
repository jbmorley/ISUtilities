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

#import "ISCancelToken.h"
#import "ISNotifier.h"

@interface ISCancelToken () {
    BOOL _cancelled;
}

@property (nonatomic, strong) ISNotifier *notifier;

@end

@implementation ISCancelToken

- (id)init
{
    self = [super init];
    if (self) {
        self.notifier = [ISNotifier new];
    }
    return self;
}

- (void)cancel
{
    @synchronized(self) {
        if (!_cancelled) {
            _cancelled = YES;
            [self.notifier notify:@selector(tokenDidCancel)];
        }
    }
}

- (BOOL)isCancelled
{
    @synchronized(self) {
        return _cancelled;
    }
}

- (void)addObserver:(id)observer
{
    [self.notifier addObserver:observer];
}

- (void)removeObserver:(id)observer
{
    [self.notifier removeObserver:observer];
}

@end
