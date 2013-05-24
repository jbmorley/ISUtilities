//
//  ISTableViewSubtitleCell.m
//  Popcorn
//
//  Created by Jason Barrie Morley on 15/04/2013.
//
//

#import "ISTableViewSubtitleCell.h"

@implementation ISTableViewSubtitleCell


- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:UITableViewCellStyleSubtitle
              reuseIdentifier:reuseIdentifier];
  if (self) {
  }
  return self;
}


- (void)setSelected:(BOOL)selected
           animated:(BOOL)animated
{
  [super setSelected:selected
            animated:animated];
}


@end
