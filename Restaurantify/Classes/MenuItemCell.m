//
//  MenuItemCell.m
//  Restaurantify
//
//  Created by Will Fairclough on 11-11-05.
//  Copyright (c) 2011 Superna. All rights reserved.
//

#import "MenuItemCell.h"

@implementation MenuItemCell
@synthesize textLabel, detailLabel, thumbnailImage;


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

@end
