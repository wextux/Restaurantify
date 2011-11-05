//
//  BYAppDelegate.m
//  Restaurantify
//
//  Created by Will Fairclough on 11-11-03.
//  Copyright (c) 2011 Superna. All rights reserved.
//

#import "BYAppDelegate.h"
#import "BYViewController.h"
#import "LLStoreWrapper.h"
#import "BYShopifyVariant.h"


@implementation BYAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[[BYViewController alloc] initWithNibName:@"BYViewController_iPhone" bundle:nil] autorelease];
    } else {
        self.viewController = [[[BYViewController alloc] initWithNibName:@"BYViewController_iPad" bundle:nil] autorelease];
    
        LLStoreWrapper *storeWrapper = [[[LLStoreWrapper alloc] init] autorelease];
        [storeWrapper setDelegate:self];
        [storeWrapper getProducts];
    
    }
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)storeWrapper:(LLStoreWrapper *)storeWrapper finishedGettingProducts:(NSArray *)products {
    //You can log the products by doing NSLog(@"%@", products);
    for (NSDictionary *product in products) {
        for (id key in [product allKeys]) {
            id value = [product objectForKey:key];
            if ([value isKindOfClass:[NSArray class]]) {
                NSArray *itemArray = (NSArray*)value;
                for (id item in itemArray) {
                    NSLog(@"item class: %@", [item class]);
                    if ([item isKindOfClass:[NSDictionary class]]) {
                        NSDictionary* newDict = (NSDictionary*)item;
                        
                        if ([newDict objectForKey:@"grams"]) {
                            BYShopifyVariant *variant = [[BYShopifyVariant alloc] initWithDictionary:newDict];
                            
                            NSLog(@"price: %@",variant.price);
                            
                        }
                        for (id subKey in [newDict allKeys]) {
                            id value = [newDict objectForKey:subKey];
                            NSLog(@"%@,    Class: %@",value, [value class]);
                        }
                    } else {
                      NSLog(@"%@,    Class: %@",item, [item class]);  
                    }
                    
                }
            } else {
                NSLog(@"%@,    Class: %@",value, [value class]);
            }
        }
    }
    
    //NSLog(@"%@", products);

}

-(void)storeWrapper:(LLStoreWrapper *)storeWrapper failedGettingProducts:(NSDictionary *)failure {
    NSLog(@"Failure: %@", failure);
}

-(void)storeWrapper:(LLStoreWrapper *)storeWrapper finishedGettingOrders:(NSArray *)orders {}
-(void)storeWrapper:(LLStoreWrapper *)storeWrapper failedGettingOrders:(NSDictionary *)failure {}


- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
