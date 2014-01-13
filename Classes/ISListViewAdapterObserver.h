//
//  ISDBViewObserver.h
//  Popcorn
//
//  Created by Jason Barrie Morley on 04/05/2013.
//
//

#import <Foundation/Foundation.h>

@class ISListViewAdapter;

@protocol ISListViewAdapterObserver <NSObject>

- (void)performBatchUpdates:(NSArray *)updates;

@end

