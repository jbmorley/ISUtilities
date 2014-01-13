//
//  ISListViewAdapterConnector.m
//  Pods
//
//  Created by Jason Barrie Morley on 13/01/2014.
//
//

#import "ISListViewAdapterConnector.h"
#import "ISListViewAdapterOperation.h"

@interface ISListViewAdapterConnector ()

@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation ISListViewAdapterConnector

+ (id)connectorWithCollectionView:(UICollectionView *)collectionView
{
  return [[self alloc] initWithCollectionView:collectionView];
}

- (id)initWithCollectionView:(UICollectionView *)collectionView
{
  self = [super init];
  if (self) {
    self.collectionView = collectionView;
  }
  return self;
}


#pragma mark - ISListViewAdapterObserver


- (void)performBatchUpdates:(NSArray *)updates
{
  [self.collectionView performBatchUpdates:^{
    for (ISListViewAdapterOperation *operation in updates) {
      if (operation.type ==
          ISListViewAdapterOperationTypeInsert) {
        [self.collectionView insertItemsAtIndexPaths:@[operation.currentIndex]];
      } else if (operation.type ==
                 ISListViewAdapterOperationTypeMove) {
        [self.collectionView moveItemAtIndexPath:operation.previousIndex
                                     toIndexPath:operation.currentIndex];
      } else if (operation.type ==
                 ISListViewAdapterOperationTypeDelete) {
        [self.collectionView deleteItemsAtIndexPaths:@[operation.previousIndex]];
      } else if (operation.type ==
                 ISListViewAdapterOperationTypeUpdate) {
        [self.collectionView reloadItemsAtIndexPaths:@[operation.currentIndex]];
      } else {
        NSLog(@"Unsupported operation: %@", operation);
      }
    }
  } completion:NULL];
}


@end
