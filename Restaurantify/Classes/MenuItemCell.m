//
//  MenuItemCell.m
//  Restaurantify
//
//  Created by Will Fairclough on 11-11-05.
//  Copyright (c) 2011 Boneyard Interactive. All rights reserved.
//

#import "MenuItemCell.h"

@implementation MenuItemCell
@synthesize textLabel, detailLabel, priceLabel, thumbnailImage;
@synthesize indicatorView;

#pragma mark - View lifecycle

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

-(void)dealloc {
    [textLabel release];
    [detailLabel release];
    [thumbnailImage release];
    [indicatorView release];
    [priceLabel release];
    [super dealloc];
}
@end
