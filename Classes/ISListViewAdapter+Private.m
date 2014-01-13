//
//  ISDBView_Private.m
//  Popcorn
//
//  Created by Jason Barrie Morley on 03/05/2013.
//
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
