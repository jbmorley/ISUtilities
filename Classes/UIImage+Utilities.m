//
// Copyright (c) 2013 InSeven Limited.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

#import "UIImage+Utilities.h"

static NSUInteger sImageIdentifier = 0;

@implementation UIImage (Utilities)

+ (NSUInteger)loadImage:(NSString *)path
              greyscale:(BOOL)greyscale
             completion:(UIImageUtilitiesCompletionBlock)completionBlock
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
             completion:(UIImageUtilitiesCompletionBlock)completionBlock
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
