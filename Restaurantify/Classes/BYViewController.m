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
#import "BYShopifyImage.h"
#import <dispatch/dispatch.h>

@interface BYViewController () 

- (void)configureCell:(MenuItemCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end

dispatch_queue_t backgroundQueue;

@implementation BYViewController
@synthesize shopifyProducts = _shopifyProducts;
@synthesize menuItemCell;
@synthesize cellNib;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    menuItemCell = [[MenuItemCell alloc] init];
    self.cellNib = [UINib nibWithNibName:@"MenuItemCell" bundle:nil];
    
    LLStoreWrapper *storeWrapper = [[LLStoreWrapper alloc] init];
    [storeWrapper setDelegate:self];
    [storeWrapper getProductsWithProductType:@"Lunch"];
    backgroundQueue = dispatch_queue_create("com.razeware.imagegrabber.bgqueue", NULL); 
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

- (void)dealloc {
    dispatch_release(backgroundQueue);
    [super dealloc];
}


#pragma LLStoreWrapperDelegate


-(void)storeWrapper:(LLStoreWrapper *)storeWrapper finishedGettingProducts:(NSMutableArray *)products {
    //You can log the products by doing NSLog(@"%@", products);

    _shopifyProducts = (NSMutableArray *)products;
    
    for (BYShopifyProduct *product in products) {
        NSLog(@"%@",product.title);
    }
    [self.tableView reloadData];
//    NSLog(@"%@", products);
    
}

-(void)storeWrapper:(LLStoreWrapper *)storeWrapper failedGettingProducts:(NSDictionary *)failure {
    NSLog(@"Failure: %@", failure);
}

-(void)storeWrapper:(LLStoreWrapper *)storeWrapper finishedGettingOrders:(NSArray *)orders {}
-(void)storeWrapper:(LLStoreWrapper *)storeWrapper failedGettingOrders:(NSDictionary *)failure {}
-(void)storeWrapper:(LLStoreWrapper *)storeWrapper finishedAddingItemToCart:(NSString *)successMsg {}
-(void)storeWrapper:(LLStoreWrapper *)storeWrapper failedAddingItemToCart:(NSDictionary *)failure {}


#pragma mark Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 133;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"%@",[_shopifyProducts count]);
    return [_shopifyProducts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    MenuItemCell *cell = (MenuItemCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [self.cellNib instantiateWithOwner:self options:nil];
        cell = menuItemCell;
        //cell = [[[MenuItemCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(MenuItemCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    BYShopifyProduct *product = [_shopifyProducts objectAtIndex:indexPath.row];
    NSLog(@"%@",product.title);
    cell.textLabel.text = product.title;
    NSString *description = [product.bodyHTML stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    description = [description stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    description = [description stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    cell.detailLabel.text = description;
    
    dispatch_async(backgroundQueue, ^(void) {
        NSString *imageUrl = [(BYShopifyImage *)[product.images objectAtIndex:0] src];
        [cell.thumbnailImage setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]]];    
    }); 
  
}


@end
