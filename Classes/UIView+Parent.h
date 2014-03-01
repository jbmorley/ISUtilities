//
//  UIView+Parent.h
//  Learn
//
//  Created by Jason Barrie Morley on 10/02/2013.
//
//

#import <UIKit/UIKit.h>

@interface UIView (Parent)

- (BOOL)resignCurrentFirstResponder;
- (BOOL)hasSuperviewOfKindOfClass:(Class)aClass;

@end
