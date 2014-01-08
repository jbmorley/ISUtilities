//
//  ISOwnerProxy.h
//  Magazines
//
//  Created by Jason Barrie Morley on 14/10/2012.
//  Copyright (c) 2012 InSeven Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISOwnerProxy : NSObject

@property (strong, nonatomic) IBOutlet UIView* view;

+ (UIView *)viewFromNib:(NSString *)nibName;
+ (id)proxyWithNibName:(NSString *)nibName;
- (id)initWithNibName:(NSString *)nibName;

@end
