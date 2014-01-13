//
//  ISDBViewOperation.m
//  
//
//  Created by Jason Barrie Morley on 13/01/2014.
//
//

#import "ISDBViewOperation.h"

@implementation ISDBViewOperation

+ (id)operationWithType:(ISDBOperation)type
                payload:(id)payload
{
  return [[self alloc] initWithType:type
                            payload:payload];
}

- (id)initWithType:(ISDBOperation)type
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
  if (self.type == ISDBOperationInsert) {
    NSNumber *index = self.payload;
    [description appendFormat:
     @"insert at %d",
     [index integerValue]];
  }
  // TODO Flesh out the operations.
  return description;
}

@end

