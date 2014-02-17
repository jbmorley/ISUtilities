//
//  ISImage.h
//  Pods
//
//  Created by Jason Barrie Morley on 17/02/2014.
//
//

#import <Foundation/Foundation.h>

typedef void (^ISImageCompletionBlock)(NSUInteger identifier,
                                       UIImage *image);

@interface ISImage : NSObject

+ (NSUInteger)loadImage:(NSString *)path
             completion:(ISImageCompletionBlock)completionBlock;
+ (NSUInteger)loadImage:(NSString *)path
              greyscale:(BOOL)greyscale
             completion:(ISImageCompletionBlock)completionBlock;
+ (UIImage *)image:(UIImage *)image
         withScale:(CGFloat)scale;
+ (UIImage *)imageWithDeviceScale:(UIImage *)image;
+ (UIImage *)convertImageToGrayScale:(UIImage *)image;

@end
