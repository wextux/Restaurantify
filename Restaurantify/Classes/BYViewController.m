//
//  BYViewController.m
//  Restaurantify
//
//  Created by Will Fairclough on 11-11-03.
//  Copyright (c) 2011 Boneyard Interactive. All rights reserved.
//

#import "BYViewController.h"
#import "LLStoreWrapper.h"
#import "BYShopifyProduct.h"


@implementation BYViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    LLStoreWrapper *storeWrapper = [[LLStoreWrapper alloc] init];
    [storeWrapper setDelegate:self];
    [storeWrapper getProducts];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}


#pragma LLStoreWrapperDelegate


-(void)storeWrapper:(LLStoreWrapper *)storeWrapper finishedGettingProducts:(NSArray *)products {
    //You can log the products by doing NSLog(@"%@", products);
    
    for (BYShopifyProduct *product in products) {
        NSLog(@"%@",product.title);
    }
    
//    NSLog(@"%@", products);
    
}

-(void)storeWrapper:(LLStoreWrapper *)storeWrapper failedGettingProducts:(NSDictionary *)failure {
    NSLog(@"Failure: %@", failure);
}

-(void)storeWrapper:(LLStoreWrapper *)storeWrapper finishedGettingOrders:(NSArray *)orders {}
-(void)storeWrapper:(LLStoreWrapper *)storeWrapper failedGettingOrders:(NSDictionary *)failure {}
-(void)storeWrapper:(LLStoreWrapper *)storeWrapper finishedAddingItemToCart:(NSString *)successMsg{}
-(void)storeWrapper:(LLStoreWrapper *)storeWrapper failedAddingItemToCart:(NSDictionary *)failure{}

@end
