//
//  ShopifyObject.m
//  Restaurantify
//
//  Created by Will Fairclough on 11-11-05.
//  Copyright (c) 2011 Boneyard Interactive. All rights reserved.
//

#import "BYShopifyObject.h"

@implementation BYShopifyObject

@synthesize identifier;
@synthesize createdAt;
@synthesize updatedAt;



-(void)dealloc {
    [identifier release];
    [createdAt release];
    [updatedAt release];
    [super dealloc];
}

@end

