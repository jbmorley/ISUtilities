//
//  ISCleanup.h
//  ISPhotoLibrary
//
//  Created by Jason Barrie Morley on 02/01/2014.
//  Copyright (c) 2014 InSeven Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ISCleanupBlock)();


@interface ISCleanup : NSObject

+ (id)cleanupWithBlock:(ISCleanupBlock)block;
- (id)initWithBlock:(ISCleanupBlock)block;

@end
