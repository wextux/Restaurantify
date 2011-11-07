//
//  BYAppDelegate.h
//  Restaurantify
//
//  Created by Will Fairclough on 11-11-03.
//  Copyright (c) 2011 Boneyard Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>



@class BYViewController;

@interface BYAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property (strong, nonatomic) BYViewController *viewController;

@end
