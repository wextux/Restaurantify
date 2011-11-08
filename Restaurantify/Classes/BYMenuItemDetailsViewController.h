//
//  BYMenuItemDetailsViewController.h
//  Restaurantify
//
//  Created by Will Fairclough on 11-11-07.
//  Copyright (c) 2011 Boneyard Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYShopifyProduct.h"
#import "LLStoreWrapper.h"

@interface BYMenuItemDetailsViewController : UIViewController <LLStoreDelegate>

@property (nonatomic, strong) BYShopifyProduct *shopifyProdutct;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UIButton *addToCartButton;

-(IBAction)addItemToCart;
@end
