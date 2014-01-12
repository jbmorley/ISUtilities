//
//  ISDBEntry.m
//  Popcorn
//
//  Created by Jason Barrie Morley on 03/05/2013.
//
//

#import "ISDBEntry.h"
#import "ISDBView_Private.h"

@interface ISDBEntry ()

@property (strong, nonatomic) ISDBView *view;
@property (nonatomic) NSUInteger index;
@property (strong, nonatomic) id identifier;

@end

@implementation ISDBEntry


+ (id)entryWithView:(ISDBView *)view
              index:(NSUInteger)index
{
  return [[self alloc] initWithView:view
                              index:index
                         identifier:nil];
}


+ (id)entryWithView:(ISDBView *)view
              index:(NSUInteger)index
         identifier:(id)identifier
{
  return [[self alloc] initWithView:view
                              index:index
                         identifier:identifier];
}


- (id)initWithView:(ISDBView *)view
             index:(NSUInteger)index
        identifier:(id)identifier
{
  self = [super init];
  if (self) {
    self.view = view;
    self.index = index;
    if (identifier == nil) {
      self.identifier = [self.view identifierForIndex:self.index];
    } else {
      self.identifier = identifier;
    }
    [self.view addObserver:self];
  }
  return self;
}


- (void)dealloc
{
  [self.view removeObserver:self];
}


- (void)fetch:(void (^)(NSDictionary *dict))completionBlock
{
  [self.view entryForIdentifier:self.identifier
                     completion:completionBlock];
}


#pragma mark - ISDBViewObserver


- (void) beginUpdates:(ISDBView *)view {}


- (void) endUpdates:(ISDBView *)view {}


- (void) view:(ISDBView *)view
 entryUpdated:(NSNumber *)index
{
  if (self.index == [index integerValue]) {
    self.index = [index integerValue];
    NSLog(@"Entry Changed");
  }
}


- (void) view:(ISDBView *)view
   entryMoved:(NSArray *)indexes {}


- (void) view:(ISDBView *)view
entryInserted:(NSNumber *)index {}


- (void) view:(ISDBView *)view
 entryDeleted:(NSNumber *)index
{
  if (self.index == [index integerValue]) {
    NSLog(@"Entry Deleted");
  }
}


@end
