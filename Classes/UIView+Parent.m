//
//  UIView+Parent.m
//  Learn
//
//  Created by Jason Barrie Morley on 10/02/2013.
//
//

#import "UIView+Parent.h"

@implementation UIView (Parent)


- (BOOL)containsCurrentFirstResponder
{
  if ([self isFirstResponder]) {
    return YES;
  }
  
  for (UIView *view in self.subviews) {
    if ([view containsCurrentFirstResponder]) {
      return YES;
    }
  }
  
  return NO;
}


- (BOOL)resignCurrentFirstResponder
{
  if ([self isFirstResponder]) {
    [self resignFirstResponder];
    return YES;
  }
  
  for (UIView *view in self.subviews) {
    if ([view resignCurrentFirstResponder]) {
      return YES;
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
