//
//  ISDBView_Private.m
//  Popcorn
//
//  Created by Jason Barrie Morley on 03/05/2013.
//
//

#import "ISDBView_Private.h"

@implementation ISDBView (Private)

- (id)identifierForIndex:(NSUInteger)index
{
  @synchronized (self) {
    ISDBEntryDescription *description = [_entries objectAtIndex:index];
    return description.identifier;
  }
}


- (void)entryForIdentifier:(id)identifier
                completion:(void (^)(NSDictionary *entry))completionBlock
{
  dispatch_async(_dispatchQueue, ^{
    NSDictionary *entry = [_dataSource entryForIdentifier:identifier];
    dispatch_async(dispatch_get_main_queue(), ^{
      completionBlock(entry);
    });
  });
}


@end
