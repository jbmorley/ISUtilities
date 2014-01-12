//
//  ISDBView_Private.h
//  Popcorn
//
//  Created by Jason Barrie Morley on 03/05/2013.
//
//

#import <Foundation/Foundation.h>
#import "ISDBView.h"

@interface ISDBView (Private)

- (id)identifierForIndex:(NSUInteger)index;
- (void)entryForIdentifier:(id)identifier
                completion:(void (^)(NSDictionary *entry))completionBlock;


@end
