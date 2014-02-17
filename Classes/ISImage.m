//
//  ISImage.m
//  Pods
//
//  Created by Jason Barrie Morley on 17/02/2014.
//
//

#import "ISImage.h"

// TODO Consider whether the API counting could be more helpful
// as a utility class.
// TODO Should these be a UIImage extension?

static NSUInteger sImageIdentifier = 0;

@implementation ISImage

+ (NSUInteger)loadImage:(NSString *)path
              greyscale:(BOOL)greyscale
             completion:(ISImageCompletionBlock)completionBlock
{
  // Count the calls.
  sImageIdentifier++;
  NSUInteger identifier = sImageIdentifier;
  
  dispatch_queue_t queue =
  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  dispatch_async(queue, ^{
    
    // Load the image file.
    NSData *data = [NSData dataWithContentsOfFile:path];
    UIImage *image = [UIImage imageWithData:data];
    
    // Account for platform scale.
    image = [self imageWithDeviceScale:image];
    
    // Convert the image to greyscale if requested.
    if (greyscale) {
      image = [self convertImageToGrayScale:image];
    }
    
    // Actually set the image and notify the completion block.
    dispatch_async(dispatch_get_main_queue(), ^{
      completionBlock(identifier, image);
    });
    
  });
  
  return sImageIdentifier;
}


+ (NSUInteger)loadImage:(NSString *)path
             completion:(ISImageCompletionBlock)completionBlock
{
  return [self loadImage:path
               greyscale:NO
              completion:completionBlock];
}


+ (UIImage *)imageWithDeviceScale:(UIImage *)image
{
  UIImage *scaledImage = image;
  CGFloat screenScale = [[UIScreen mainScreen] scale];
  if (screenScale != 1.0) {
    scaledImage = [self image:image
              withScale:screenScale];
  } else {
    scaledImage = [image copy];
  }
  return scaledImage;
}


+ (UIImage *)image:(UIImage *)image
         withScale:(CGFloat)scale
{
  return [UIImage imageWithCGImage:[image CGImage]
                             scale:scale
                       orientation:UIImageOrientationUp];
}


+ (UIImage *)convertImageToGrayScale:(UIImage *)image
{
  CGRect imageRect = CGRectMake(0,
                                0,
                                image.size.width,
                                image.size.height);
  
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
  CGContextRef context =
  CGBitmapContextCreate(nil,
                        image.size.width,
                        image.size.height,
                        8,
                        0,
                        colorSpace,
                        0);
  
  CGContextDrawImage(context, imageRect, [image CGImage]);
  
  CGContextSetBlendMode(context, kCGBlendModeScreen);
  CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 0.1);
  CGContextFillRect(context, imageRect);
  
  CGImageRef imageRef = CGBitmapContextCreateImage(context);
  UIImage *newImage = [UIImage imageWithCGImage:imageRef];
  //  CFRelease(imageRef); // TODO?
  CGContextRelease(context);
  CGColorSpaceRelease(colorSpace);
  
  return newImage;
}

@end
