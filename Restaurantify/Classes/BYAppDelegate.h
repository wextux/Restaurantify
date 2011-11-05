//
//  BYAppDelegate.h
//  Restaurantify
//
//  Created by Will Fairclough on 11-11-03.
//  Copyright (c) 2011 Superna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLStoreWrapper.h"
#import "BYShopifyVariant.h"


@class BYViewController;

@interface BYAppDelegate : UIResponder <UIApplicationDelegate, LLStoreDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) BYViewController *viewController;

@end
