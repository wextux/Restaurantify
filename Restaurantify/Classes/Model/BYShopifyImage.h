//
//  BYShopifyImage.h
//  Restaurantify
//
//  Created by Will Fairclough on 11-11-05.
//  Copyright (c) 2011 Boneyard Interactive. All rights reserved.
//

#import "BYShopifyObject.h"

@interface BYShopifyImage : BYShopifyObject

@property (strong, nonatomic) NSNumber *position;
@property (strong, nonatomic) NSNumber *productId;
@property (strong, nonatomic) NSString *src;


- (id)initWithDictionary:(NSDictionary *)dictionary;
- (void)setObjectWithDictionary:(NSDictionary *)jsonImageDictionary;
@end
