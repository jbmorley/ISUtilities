//
//  ISDBView_Private.m
//  Popcorn
//
//  Created by Jason Barrie Morley on 03/05/2013.
//
//

#import "ISListViewAdapter_Private.h"

@implementation ISListViewAdapter (Private)

- (id)identifierForIndex:(NSUInteger)index
{
  @synchronized (self) {
    ISListViewAdapterItemDescription *description = [_entries objectAtIndex:index];
    return description.identifier;
  }
}


- (void)entryForIdentifier:(id)identifier
                completion:(ISListViewAdapterItemBlock)completionBlock
{
  dispatch_async(_dispatchQueue, ^{
    NSDictionary *entry = [_dataSource adapter:self
                            entryForIdentifier:identifier];
    dispatch_async(dispatch_get_main_queue(), ^{
      completionBlock(entry);
    });
  });
}


@end
