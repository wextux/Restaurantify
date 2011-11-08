//
//  BYMenuItemDetailsViewController.m
//  Restaurantify
//
//  Created by Will Fairclough on 11-11-07.
//  Copyright (c) 2011 Superna. All rights reserved.
//

#import "BYMenuItemDetailsViewController.h"
#import "BYShopifyVariant.h"


@implementation BYMenuItemDetailsViewController
@synthesize shopifyProdutct = _shopifyProdutct;
@synthesize titleLabel, addToCartButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    self.title = _shopifyProdutct.title;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    titleLabel.text = _shopifyProdutct.title;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark LLStoreWrapper Delegate

-(void)storeWrapper:(LLStoreWrapper *)storeWrapper finishedGettingProducts:(NSMutableArray *)products {}
-(void)storeWrapper:(LLStoreWrapper *)storeWrapper failedGettingProducts:(NSDictionary *)failure {}
-(void)storeWrapper:(LLStoreWrapper *)storeWrapper finishedGettingOrders:(NSArray *)orders {}
-(void)storeWrapper:(LLStoreWrapper *)storeWrapper failedGettingOrders:(NSDictionary *)failure {}
-(void)storeWrapperFinishedAddingItemToCart:(LLStoreWrapper *)storeWrapper withRequest:(ASIFormDataRequest *)request {
    NSLog(@"URL: %@", [request url]);
}
-(void)storeWrapper:(LLStoreWrapper *)storeWrapper failedAddingItemToCart:(NSDictionary *)failure {
    NSLog(@"Failure: %@", failure);
}


#pragma mark - Actions


-(IBAction)addItemToCart {
    LLStoreWrapper *storeWrapper = [[LLStoreWrapper alloc] init];
    [storeWrapper setDelegate:self];
    [storeWrapper addItemToCart:[(BYShopifyVariant *)[[_shopifyProdutct variants] objectAtIndex:0] identifier]];
    [storeWrapper release];
}

#pragma mark - Clean Up

-(void)dealloc {
    [addToCartButton release];
    [titleLabel release];
    [_shopifyProdutct release];
    [super dealloc];
}

@end
