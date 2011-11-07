//
//  BYMenuItemDetailsViewController.h
//  Restaurantify
//
//  Created by Will Fairclough on 11-11-07.
//  Copyright (c) 2011 Superna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYShopifyProduct.h"


@interface BYMenuItemDetailsViewController : UIViewController

@property (nonatomic, strong) BYShopifyProduct *shopifyProdutct;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;

@end
