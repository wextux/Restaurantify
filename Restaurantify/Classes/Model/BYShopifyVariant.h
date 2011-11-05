//
//  BYShopifyVariant.h
//  Restaurantify
//
//  Created by Will Fairclough on 11-11-05.
//  Copyright (c) 2011 Boneyard Interactive. All rights reserved.
//

#import "BYShopifyObject.h"

@interface BYShopifyVariant : BYShopifyObject {
    Boolean requiresShipping;
    Boolean taxable;
}

@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSNumber *position;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *inventoryPolicy;
@property (strong, nonatomic) NSString *compareAtPrice;
@property (strong, nonatomic) NSString *inventoryQuantity;
@property (strong, nonatomic) NSString *inventoryManagement;
@property (strong, nonatomic) NSNumber *grams;
@property (strong, nonatomic) NSString *sku;
@property (strong, nonatomic) NSString *option1;
@property (strong, nonatomic) NSString *option2;
@property (strong, nonatomic) NSString *option3;
@property (strong, nonatomic) NSString *fulfillmentService;

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (void)setObjectWithDictionary:(NSDictionary *)variantDictionary;
@end
