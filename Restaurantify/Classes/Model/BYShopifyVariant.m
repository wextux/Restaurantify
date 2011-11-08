//
//  BYShopifyVariant.m
//  Restaurantify
//
//  Created by Will Fairclough on 11-11-05.
//  Copyright (c) 2011 Boneyard Interactive. All rights reserved.
//

#import "BYShopifyVariant.h"

@implementation BYShopifyVariant
@synthesize position;
@synthesize price;
@synthesize title;
@synthesize inventoryPolicy;
@synthesize inventoryQuantity;
@synthesize inventoryManagement;
@synthesize fulfillmentService;
@synthesize option1;
@synthesize option2;
@synthesize option3;
@synthesize grams;
@synthesize sku;
@synthesize compareAtPrice;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if ((self = [self init]) != NULL)
    {
        [self setObjectWithDictionary:dictionary];
    }
    return(self);
}

- (Boolean)requiresShipping {
    return requiresShipping;
}

- (Boolean)taxable {
    return taxable;
}

- (void)setObjectWithDictionary:(NSDictionary *)variantDictionary {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    for (NSString *key in [variantDictionary allKeys]) {
        id value = [variantDictionary objectForKey:key];
        
        if ([key isEqualToString:@"price"]) {
            [self setPrice:value];
        } else if ([key isEqualToString:@"position"]) {
            [self setPosition:value];
        } else if ([key isEqualToString:@"created_at"]) {
            NSString *dateStr = (NSString *)value;
            dateStr = [dateStr stringByReplacingOccurrencesOfString:@"T" withString:@" "];
            dateStr = [dateStr stringByReplacingOccurrencesOfString:@"Z" withString:@""];
            NSDate *date = [dateFormatter dateFromString:dateStr];
            
            [self setCreatedAt:date];
        } else if ([key isEqualToString:@"title"]) {
            [self setTitle:value];
        } else if ([key isEqualToString:@"requires_shipping"]) {
            NSNumber *numBool = (NSNumber *)value;
            if ([numBool isEqualToNumber:[NSNumber numberWithInt:0]]) {
                requiresShipping = NO;
            } else {
                requiresShipping = YES;
            }
        } else if ([key isEqualToString:@"updated_at"]) {
            NSString *dateStr = (NSString *)value;
            dateStr = [dateStr stringByReplacingOccurrencesOfString:@"T" withString:@" "];
            dateStr = [dateStr stringByReplacingOccurrencesOfString:@"Z" withString:@""];
            NSDate *date = [dateFormatter dateFromString:dateStr];
            
            [self setUpdatedAt:date];
        } else if ([key isEqualToString:@"inventory_policy"]) {
            [self setInventoryPolicy:value];
        } else if ([key isEqualToString:@"compare_at_price"]) {
            [self setCompareAtPrice:value];
        } else if ([key isEqualToString:@"inventory_quantity"]) {
            [self setInventoryQuantity:value];
        } else if ([key isEqualToString:@"inventory_management"]) {
            [self setInventoryManagement:value];
        } else if ([key isEqualToString:@"taxable"]) {
            NSNumber *numBool = (NSNumber *)value;
            if ([numBool isEqualToNumber:[NSNumber numberWithInt:0]]) {
                taxable = NO;
            } else {
                taxable = YES;
            }
        } else if ([key isEqualToString:@"id"]) {
            [self setIdentifier:value];
        } else if ([key isEqualToString:@"grams"]) {
            [self setGrams:value];
        } else if ([key isEqualToString:@"sku"]) {
            [self setSku:value];
        } else if ([key isEqualToString:@"option1"]) {
            [self setOption1:value];
        } else if ([key isEqualToString:@"option2"]) {
            [self setOption2:value];           
        } else if ([key isEqualToString:@"option3"]) {
            [self setOption3:value];
        } else if ([key isEqualToString:@"fulfillment_service"]) {
            [self setFulfillmentService:value];
        }
    
    }
    
    [dateFormatter release];
}

-(void)dealloc {
    [position release];
    [price release];
    [title release];
    [inventoryPolicy release];
    [inventoryQuantity release];
    [inventoryManagement release];
    [fulfillmentService release];
    [option1 release];
    [option2 release];
    [option3 release];
    [grams release];
    [sku release];
    [compareAtPrice release];
    [super dealloc];
}
@end
