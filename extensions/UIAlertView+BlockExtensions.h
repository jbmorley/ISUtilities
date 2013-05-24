//
//  UIAlertView+BlockExtensions.h
//  Learn
//
//  Created by Jason Barrie Morley on 16/10/2012.
//
//

@interface UIAlertView (BlockExtensions) <UIAlertViewDelegate>

- (id)initWithTitle:(NSString *)title message:(NSString *)message completionBlock:(void (^)(NSUInteger buttonIndex))block cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

@end