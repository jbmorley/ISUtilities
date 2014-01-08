//
//  ISOwnerProxy.m
//  Magazines
//
//  Created by Jason Barrie Morley on 14/10/2012.
//  Copyright (c) 2012 InSeven Limited. All rights reserved.
//

#import "ISOwnerProxy.h"

@implementation ISOwnerProxy

+ (UIView *)viewFromNib:(NSString *)nibName
{
  ISOwnerProxy *proxy = [self proxyWithNibName:nibName];
  return proxy.view;
}

+ (id)proxyWithNibName:(NSString *)nibName
{
  return [[self alloc] initWithNibName:nibName];
}

- (id)initWithNibName:(NSString *)nibName
{
  self = [super init];
  if (self) {
    [[NSBundle mainBundle] loadNibNamed:nibName
                                  owner:self
                                options:nil];
  }
  return self;
}

@end
