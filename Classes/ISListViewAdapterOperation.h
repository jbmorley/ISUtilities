//
//  ISDBViewOperation.h
//  
//
//  Created by Jason Barrie Morley on 13/01/2014.
//
//

#import <Foundation/Foundation.h>
#import "ISListViewAdapterOperationType.h"

@interface ISListViewAdapterOperation : NSObject

@property (nonatomic) ISListViewAdapterOperationType type;
@property (strong, nonatomic) id payload;

+ (id)operationWithType:(ISListViewAdapterOperationType)type
                payload:(id)payload;
- (id)initWithType:(ISListViewAdapterOperationType)type
           payload:(id)payload;

@end
