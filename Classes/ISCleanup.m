//
//  ISCleanup.m
//  ISPhotoLibrary
//
//  Created by Jason Barrie Morley on 02/01/2014.
//  Copyright (c) 2014 InSeven Limited. All rights reserved.
//

#import "ISCleanup.h"

@interface ISCleanup ()

@property (nonatomic, copy) ISCleanupBlock block;

@end

@implementation ISCleanup


+ (id)cleanupWithBlock:(ISCleanupBlock)block
{
  return [[self alloc] initWithBlock:block];
}


- (id)initWithBlock:(ISCleanupBlock)block
{
  self = [super init];
  if (self) {
    self.block = block;
  }
  return self;
}


- (void)dealloc
{
  self.block();
}

@end
