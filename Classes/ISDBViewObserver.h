//
//  ISDBViewObserver.h
//  Popcorn
//
//  Created by Jason Barrie Morley on 04/05/2013.
//
//

#import <Foundation/Foundation.h>

@class ISDBView;

@protocol ISDBViewObserver <NSObject>

- (void)beginUpdates:(ISDBView *)view;
- (void)endUpdates:(ISDBView *)view;
- (void)view:(ISDBView *)view
entryUpdated:(NSNumber *)index;
- (void)view:(ISDBView *)view
   entryMoved:(NSArray *)indexes;
- (void)view:(ISDBView *)view
entryInserted:(NSNumber *)index;
- (void)view:(ISDBView *)view
 entryDeleted:(NSNumber *)index;

@end

