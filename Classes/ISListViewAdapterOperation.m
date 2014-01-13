//
//  ISDBViewOperation.m
//  
//
//  Created by Jason Barrie Morley on 13/01/2014.
//
//

#import "ISListViewAdapterOperation.h"

@implementation ISListViewAdapterOperation

+ (id)operationWithType:(ISListViewAdapterOperationType)type
                payload:(id)payload
{
  return [[self alloc] initWithType:type
                            payload:payload];
}

- (id)initWithType:(ISListViewAdapterOperationType)type
           payload:(id)payload
{
  self = [super init];
  if (self) {
    self.type = type;
    self.payload = payload;
  }
  return self;
}


- (NSString *)description
{
  NSMutableString *description = [NSMutableString stringWithCapacity:3];
  if (self.type == ISListViewAdapterOperationTypeInsert) {
    NSNumber *index = self.payload;
    [description appendFormat:
     @"insert at %ld",
     (long)[index integerValue]];
  }
  // TODO Flesh out the operations.
  return description;
}

@end

