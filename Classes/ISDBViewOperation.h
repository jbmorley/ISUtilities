//
//  ISDBViewOperation.h
//  
//
//  Created by Jason Barrie Morley on 13/01/2014.
//
//

#import <Foundation/Foundation.h>
#import "ISDBOperation.h"

@interface ISDBViewOperation : NSObject

@property (nonatomic) ISDBOperation type;
@property (strong, nonatomic) id payload;

+ (id)operationWithType:(ISDBOperation)type
                payload:(id)payload;
- (id)initWithType:(ISDBOperation)type
           payload:(id)payload;

@end
