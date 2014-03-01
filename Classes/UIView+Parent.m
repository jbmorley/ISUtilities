//
//  UIView+Parent.m
//  Learn
//
//  Created by Jason Barrie Morley on 10/02/2013.
//
//

#import "UIView+Parent.h"

@implementation UIView (Parent)


- (BOOL)resignCurrentFirstResponder
{
  if ([self isFirstResponder]) {
    
    // Check ourselves.
    [self resignFirstResponder];
    return YES;
    
  } else {
    
    // Iterate over our children.
    for (UIView *view in self.subviews) {
      if ([view resignCurrentFirstResponder]) {
        return YES;
      }
    }
    
  }
  return NO;
}

- (BOOL)hasSuperviewOfKindOfClass:(Class)aClass
{
  if ([self isKindOfClass:aClass]) {
    return YES;
  } else {
    return [self.superview hasSuperviewOfKindOfClass:aClass];
  }
}

@end
