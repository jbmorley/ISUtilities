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
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic) UITableViewRowAnimation animation;

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


+ (id)connectorWithTableView:(UITableView *)tableView
{
  return [[self alloc] initWithTableView:tableView];
}


- (id)initWithTableView:(UITableView *)tableView
{
  self = [super init];
  if (self) {
    self.tableView = tableView;
    self.animation = UITableViewRowAnimationAutomatic;
  }
  return self;
}


#pragma mark - ISListViewAdapterObserver


- (void)performBatchUpdates:(NSArray *)updates
{
  if (self.collectionView) {
    
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
    
  } else if (self.tableView) {
    
    [self.tableView beginUpdates];
    
    for (ISListViewAdapterOperation *operation in updates) {
      if (operation.type ==
          ISListViewAdapterOperationTypeInsert) {
        [self.tableView insertRowsAtIndexPaths:@[operation.currentIndex]
                              withRowAnimation:self.animation];
      } else if (operation.type ==
                 ISListViewAdapterOperationTypeMove) {
        [self.tableView moveRowAtIndexPath:operation.previousIndex
                               toIndexPath:operation.currentIndex];
      } else if (operation.type ==
                 ISListViewAdapterOperationTypeDelete) {
        [self.tableView deleteRowsAtIndexPaths:@[operation.previousIndex]
                              withRowAnimation:self.animation];
      } else if (operation.type ==
                 ISListViewAdapterOperationTypeUpdate) {
        [self.tableView reloadRowsAtIndexPaths:@[operation.currentIndex]
                              withRowAnimation:self.animation];
      } else {
        NSLog(@"Unsupported operation: %@", operation);
      }
    }
    
    [self.tableView endUpdates];
    
  }
}


@end
