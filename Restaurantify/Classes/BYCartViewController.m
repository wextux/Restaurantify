//
//  BYCartViewController.m
//  Restaurantify
//
//  Created by Will Fairclough on 11-11-08.
//  Copyright (c) 2011 Boneyard Interactive. All rights reserved.
//

#import "BYCartViewController.h"

@implementation BYCartViewController
@synthesize urlRequest;
@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andURLRequest:(NSURLRequest *)request
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        urlRequest = request;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [webView loadRequest:urlRequest];
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

-(void)dealloc {
    [urlRequest release];
    [webView release];
    [super dealloc];
}

@end
