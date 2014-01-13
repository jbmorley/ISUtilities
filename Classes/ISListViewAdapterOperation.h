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
@property (nonatomic, strong) NSIndexPath *currentIndex;
@property (nonatomic, strong) NSIndexPath *previousIndex;

@end
