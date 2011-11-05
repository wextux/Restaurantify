//
//  BYShopifyProduct.h
//  Restaurantify
//
//  Created by Will Fairclough on 11-11-05.
//  Copyright (c) 2011 Boneyard Interactive. All rights reserved.
//

#import "BYShopifyObject.h"

@interface BYShopifyProduct : BYShopifyObject

@property (strong, nonatomic) NSString *bodyHTML;
@property (strong, nonatomic) NSString *handle;
@property (strong, nonatomic) NSString *productType;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *tags;
@property (strong, nonatomic) NSString *vendor;
@property (strong, nonatomic) NSDate *publishedAt;
@property (strong, nonatomic) NSMutableArray *variants; //BYShopifyVariant
@property (strong, nonatomic) NSMutableArray *images;   //BYShopifyImage

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (void)setObjectWithDictionary:(NSDictionary *)jsonProductDictionary;

@end
