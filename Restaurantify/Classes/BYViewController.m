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
#import "EGOTableViewPullRefresh.h"
#import "BYMenuItemDetailsViewController.h"


@interface BYViewController () 

- (void)configureCell:(MenuItemCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end

dispatch_queue_t backgroundQueue;
@interface BYViewController () {
@private
    CGFloat rowHeight;
}
@end
@implementation BYViewController
@synthesize navController = _navController;
@synthesize shopifyProducts = _shopifyProducts;
@synthesize menuItemCell;
@synthesize cellNib;
@synthesize egoTableView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    self.title = @"Menu";
    
    _shopifyProducts = [[NSMutableArray alloc] init];

    menuItemCell = [[MenuItemCell alloc] init];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        rowHeight = 87.0f;
        self.cellNib = [UINib nibWithNibName:@"MenuItemCell_iPhone" bundle:nil];
    } else {
        rowHeight = 133.0f;
        self.cellNib = [UINib nibWithNibName:@"MenuItemCell_iPad" bundle:nil];
    }
    
    // Adjusted frame for egoTableView with a Nav Bar
    CGRect frame = self.view.bounds;
	frame.size.height = frame.size.height - 40;
    
    egoTableView = [[EGOTableViewPullRefresh alloc] initWithFrame:frame style:UITableViewStylePlain];
	egoTableView.dataSource = self;
	egoTableView.delegate = self;
    [self.view addSubview:egoTableView];
    
    LLStoreWrapper *storeWrapper = [[LLStoreWrapper alloc] init];
    [storeWrapper setDelegate:self];
    [storeWrapper getProductsWithProductType:@"Breakfast"];
    [storeWrapper release];
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    _navController = nil;
    menuItemCell = nil;
    cellNib = nil;
    //egoTableView = nil;
    _shopifyProducts = nil;
    [super viewDidUnload];
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
    [_shopifyProducts release];
    [menuItemCell release];
    [cellNib release];
    [super dealloc];
}


#pragma mark LLStoreWrapper Delegate

-(void)storeWrapper:(LLStoreWrapper *)storeWrapper finishedGettingProducts:(NSMutableArray *)products {
    // Must call release on the Array so that all object in the array are released before it loads up a new list
    [_shopifyProducts release];
    _shopifyProducts = [[NSMutableArray alloc] initWithCapacity:[products count]];
    [_shopifyProducts addObjectsFromArray:products];
    [egoTableView reloadData];
}

-(void)storeWrapper:(LLStoreWrapper *)storeWrapper failedGettingProducts:(NSDictionary *)failure {
    NSLog(@"Failure: %@", failure);
}

-(void)storeWrapper:(LLStoreWrapper *)storeWrapper finishedGettingOrders:(NSArray *)orders {}
-(void)storeWrapper:(LLStoreWrapper *)storeWrapper failedGettingOrders:(NSDictionary *)failure {}
-(void)storeWrapperFinishedAddingItemToCart:(LLStoreWrapper *)storeWrapper withRequest:(ASIFormDataRequest *)request {
    NSLog(@"URL: %@", [request url]);
}
-(void)storeWrapper:(LLStoreWrapper *)storeWrapper failedAddingItemToCart:(NSDictionary *)failure {}


#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_shopifyProducts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    MenuItemCell *cell = (MenuItemCell *)[egoTableView dequeueReusableCellWithIdentifier:CellIdentifier];
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
    cell.textLabel.text = product.title;
    NSString *description = [product.bodyHTML stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    description = [description stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    description = [description stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    cell.detailLabel.text = description;
    cell.priceLabel.text = [NSString stringWithFormat:@"$%@", [(BYShopifyVariant *)[product.variants objectAtIndex:0] price]];
    backgroundQueue = dispatch_queue_create("com.boneyard.imagefetcher.bgqueue", NULL); 
    [cell.indicatorView startAnimating];
    
    dispatch_async(backgroundQueue, ^(void) {
        NSString *imageUrl = [(BYShopifyImage *)[product.images objectAtIndex:0] src];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell.thumbnailImage setImage:image];
            [cell.indicatorView stopAnimating];
        });
    }); 
    
    dispatch_release(backgroundQueue);
  
}


#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *nibName = [[NSString alloc] init];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        nibName = @"MenuItemDetailsViewController_iPhone";
    } else {
        nibName = @"MenuItemDetailsViewController_iPad";
    }
    
    BYMenuItemDetailsViewController *menuItemViewController = [[[BYMenuItemDetailsViewController alloc] initWithNibName:nibName bundle:nil] autorelease];
    menuItemViewController.shopifyProdutct = [_shopifyProducts objectAtIndex:indexPath.row];
    
    [_navController pushViewController:menuItemViewController animated:YES];
    
    [nibName release];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - EGOTableView Forward Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView; {
	[egoTableView scrollViewWillBeginDragging:scrollView];
} 

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {	
	[egoTableView scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	[egoTableView scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}



#pragma mark - EGOTableViewPullRefresh Delegate

- (void)reloadTableViewDataSource{
    LLStoreWrapper *storeWrapper = [[LLStoreWrapper alloc] init];
    [storeWrapper setDelegate:self];
    [storeWrapper getProductsWithProductType:@"Lunch"];
    [storeWrapper release];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
}


- (void)doneLoadingTableViewData{
	[egoTableView dataSourceDidFinishLoadingNewData];
}



@end
