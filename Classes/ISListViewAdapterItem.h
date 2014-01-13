//
//  ISDBEntry.h
//  Popcorn
//
//  Created by Jason Barrie Morley on 03/05/2013.
//
//

#import <Foundation/Foundation.h>
#import "ISListViewAdapter.h"
#import "ISListViewAdapterObserver.h"
#import "ISListViewAdapterBlock.h"


@interface ISListViewAdapterItem : NSObject

+ (id)entryWithAdapter:(ISListViewAdapter *)adapter
                 index:(NSUInteger)index;
+ (id)entryWithAdapter:(ISListViewAdapter *)adapter
                 index:(NSUInteger)index
            identifier:(id)identifier;
- (id)initWithAdapter:(ISListViewAdapter *)adapter
                index:(NSUInteger)index
           identifier:(id)identifier;
- (void)fetch:(ISListViewAdapterBlock)completionBlock;

@end
