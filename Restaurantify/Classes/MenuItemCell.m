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
    NSLog(@"Menu Cell is deallocing");
    [textLabel release];
    [detailLabel release];
    [thumbnailImage release];
    [indicatorView release];
    [super dealloc];
}
@end
