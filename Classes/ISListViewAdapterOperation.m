//
//  ISDBViewOperation.m
//  
//
//  Created by Jason Barrie Morley on 13/01/2014.
//
//

#import "ISListViewAdapterOperation.h"

@implementation ISListViewAdapterOperation


- (NSString *)description
{
  NSMutableString *description = [NSMutableString stringWithCapacity:3];
  if (self.type == ISListViewAdapterOperationTypeInsert) {
    [description appendFormat:@"insert"];
  }
  // TODO Flesh out the operations.
  return description;
}

@end

