//
//  ISDBView_Private.h
//  Popcorn
//
//  Created by Jason Barrie Morley on 03/05/2013.
//
//

#import <Foundation/Foundation.h>
#import "ISListViewAdapter.h"
#import "ISListViewAdapterBlock.h"

@interface ISListViewAdapter (Private)

- (id)identifierForIndex:(NSUInteger)index;
- (void)entryForIdentifier:(id)identifier
                completion:(ISListViewAdapterBlock)completionBlock;


@end
