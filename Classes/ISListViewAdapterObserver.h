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

@optional
- (void)beginUpdates:(ISListViewAdapter *)view;
- (void)endUpdates:(ISListViewAdapter *)view;
- (void)view:(ISListViewAdapter *)view
entryUpdated:(NSNumber *)index;
- (void)view:(ISListViewAdapter *)view
   entryMoved:(NSArray *)indexes;
- (void)view:(ISListViewAdapter *)view
entryInserted:(NSNumber *)index;
- (void)view:(ISListViewAdapter *)view
 entryDeleted:(NSNumber *)index;
- (void)performBatchUpdates:(NSArray *)updates;

@end

