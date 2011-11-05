//
//  ShopifyObject.h
//  Restaurantify
//
//  Created by Will Fairclough on 11-11-05.
//  Copyright (c) 2011 Boneyard Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYShopifyObject : NSObject
@property (strong, nonatomic) NSNumber *identifier;    
@property (strong, nonatomic) NSDate *createdAt;
@property (strong, nonatomic) NSDate *updatedAt;

@end
