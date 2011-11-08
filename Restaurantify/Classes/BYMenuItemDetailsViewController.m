//
//  BYMenuItemDetailsViewController.m
//  Restaurantify
//
//  Created by Will Fairclough on 11-11-07.
//  Copyright (c) 2011 Superna. All rights reserved.
//

#import "BYMenuItemDetailsViewController.h"

@implementation BYMenuItemDetailsViewController
@synthesize shopifyProdutct = _shopifyProdutct;
@synthesize titleLabel;

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

-(void)dealloc {
    [titleLabel release];
    [_shopifyProdutct release];
    [super dealloc];
}

@end
