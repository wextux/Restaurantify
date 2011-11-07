//
//  BYViewController.h
//  Restaurantify
//
//  Created by Will Fairclough on 11-11-03.
//  Copyright (c) 2011 Boneyard Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLStoreWrapper.h"
#import "BYShopifyVariant.h"
#import "MenuItemCell.h"

@class EGOTableViewPullRefresh;
@interface BYViewController : UIViewController <LLStoreDelegate, UITableViewDelegate, UITableViewDataSource> {
    
    IBOutlet EGOTableViewPullRefresh *egoTableView;
    
}

@property (nonatomic, strong) UINib *cellNib;
@property (nonatomic, strong) IBOutlet MenuItemCell *menuItemCell;
@property (nonatomic, strong) NSMutableArray *shopifyProducts;
@property (nonatomic, strong) IBOutlet EGOTableViewPullRefresh *egoTableView;
@property (nonatomic, strong) UINavigationController *navController;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
@end
