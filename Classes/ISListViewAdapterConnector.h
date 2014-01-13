//
//  ISListViewAdapterConnector.h
//  Pods
//
//  Created by Jason Barrie Morley on 13/01/2014.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ISListViewAdapterObserver.h"

@interface ISListViewAdapterConnector : NSObject <ISListViewAdapterObserver>

+ (id)connectorWithCollectionView:(UICollectionView *)collectionView;
- (id)initWithCollectionView:(UICollectionView *)collectionView;

+ (id)connectorWithTableView:(UITableView *)tableView;
- (id)initWithTableView:(UITableView *)tableView;

@end
