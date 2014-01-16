//
// Copyright (c) 2013 InSeven Limited.
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

#import "ISListViewAdapter+Private.h"

@implementation ISListViewAdapter (Private)

- (id)identifierForIndex:(NSUInteger)index
{
  @synchronized (self) {
    // TODO What's going on here. I cannot believe that
    // requesting this every time is performant?
    ISListViewAdapterItemDescription *description = [_entries objectAtIndex:index];
    return description.identifier;
  }
}


// TODO Where is this function called? Is it actually
// required?
- (void)entryForIdentifier:(id)identifier
                completion:(ISListViewAdapterBlock)completionBlock
{
  // TODO This doesn't need to be dispatched on a different
  // thread any more.
  [_dataSource adapter:self
    entryForIdentifier:identifier
       completionBlock:completionBlock];
}


@end
