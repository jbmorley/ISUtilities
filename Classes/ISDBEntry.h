//
//  ISDBEntry.h
//  Popcorn
//
//  Created by Jason Barrie Morley on 03/05/2013.
//
//

#import <Foundation/Foundation.h>
#import "ISDBView.h"
#import "ISDBViewObserver.h"

@interface ISDBEntry : NSObject <ISDBViewObserver>

+ (id)entryWithView:(ISDBView *)view
              index:(NSUInteger)index;
+ (id)entryWithView:(ISDBView *)view
              index:(NSUInteger)index
        identifier:(id)identifier;
- (id)initWithView:(ISDBView *)view
             index:(NSUInteger)index
        identifier:(id)identifier;
- (void)fetch:(void (^)(NSDictionary *dict))completionBlock;

@end
