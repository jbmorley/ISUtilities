//
//  NSDictionary+Serialize.m
//  Pods
//
//  Created by Jason Barrie Morley on 26/02/2014.
//
//

#import "NSObject+Serialize.h"

@implementation NSObject (Serialize)

- (BOOL)canWriteToFile
{
  // Check as a dictionary.
  if ([self isKindOfClass:[NSDictionary class]]) {
    
    __block BOOL result = YES;
    NSDictionary *dictionary = (NSDictionary *)self;
    [dictionary enumerateKeysAndObjectsUsingBlock:
     ^(id key, id obj, BOOL *stop) {
       
       if (![key canWriteToFile]) {
         result = NO;
         *stop = YES;
         return;
       }
       
       if (![obj canWriteToFile]) {
         result = NO;
         *stop = YES;
         return;
       }
       
     }];
    
    return result;
    
  }
  
  // Check as an array.
  if ([self isKindOfClass:[NSArray class]]) {
    
    __block BOOL result = YES;
    NSArray *array = (NSArray *)self;
    [array enumerateObjectsUsingBlock:
     ^(id obj, NSUInteger idx, BOOL *stop) {
       
       if (![obj canWriteToFile]) {
         result = NO;
         *stop = YES;
         return;
       }
       
     }];
    
    return result;
    
  }
  
  // Check basic classes.
  return [self isKindOfClass:[NSData class]] ||
         [self isKindOfClass:[NSDate class]] ||
         [self isKindOfClass:[NSNumber class]] ||
         [self isKindOfClass:[NSString class]];

}
   
   
@end
