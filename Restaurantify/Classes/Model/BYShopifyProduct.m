//
//  BYShopifyProduct.m
//  Restaurantify
//
//  Created by Will Fairclough on 11-11-05.
//  Copyright (c) 2011 Boneyard Interactive. All rights reserved.
//

#import "BYShopifyProduct.h"
#import "BYShopifyVariant.h"
#import "BYShopifyImage.h"

@implementation BYShopifyProduct
@synthesize tags;
@synthesize title;
@synthesize handle;
@synthesize vendor;
@synthesize bodyHTML;
@synthesize productType;
@synthesize publishedAt;
@synthesize variants;
@synthesize images;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if ((self = [self init]) != NULL)
    {
        
        [self setObjectWithDictionary:dictionary];
    }
    return(self);
}

- (void)setObjectWithDictionary:(NSDictionary *)jsonProductDictionary {

    for (NSString *key in [jsonProductDictionary allKeys]) {
        id value = [jsonProductDictionary objectForKey:key];
    
        if ([key isEqualToString:@"variants"]) {
        
            NSArray *jsonVariants = (NSArray*)value;
            variants = [[NSMutableArray alloc] initWithCapacity:[jsonVariants count]];
            
            for (NSDictionary *variant in jsonVariants) {
                BYShopifyVariant *shopifyVariant = [[BYShopifyVariant alloc] initWithDictionary:variant];
                [variants addObject:shopifyVariant];
                [shopifyVariant release];
            }
            
        } else if ([key isEqualToString:@"images"]) {
        
            NSArray *jsonImages = (NSArray*)value;
            images = [[NSMutableArray alloc] initWithCapacity:[jsonImages count]];
            
            for (NSDictionary *image in jsonImages) {
                BYShopifyImage *shopifyImage = [[BYShopifyImage alloc] initWithDictionary:image];
                [images addObject:shopifyImage];
                [shopifyImage release];
            }
            
        } else if ([key isEqualToString:@"tags"]) {
            [self setTags:value];
        } else if ([key isEqualToString:@"handle"]) {
            [self setHandle:value];
        } else if ([key isEqualToString:@"body_html"]) {
            [self setBodyHTML:value];
        } else if ([key isEqualToString:@"product_type"]) {
            [self setProductType:value];
        } else if ([key isEqualToString:@"published_at"]) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *dateStr = (NSString *)value;
            dateStr = [dateStr stringByReplacingOccurrencesOfString:@"T" withString:@" "];
            dateStr = [dateStr stringByReplacingOccurrencesOfString:@"Z" withString:@""];
            NSDate *date = [dateFormatter dateFromString:dateStr];
            
            [self setPublishedAt:date];
            [dateFormatter release];
        } else if ([key isEqualToString:@"vendor"]) {
            [self setVendor:value];
        } else if ([key isEqualToString:@"title"]) {
            [self setTitle:value];
        } else if ([key isEqualToString:@"created_at"]) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *dateStr = (NSString *)value;
            dateStr = [dateStr stringByReplacingOccurrencesOfString:@"T" withString:@" "];
            dateStr = [dateStr stringByReplacingOccurrencesOfString:@"Z" withString:@""];
            NSDate *date = [dateFormatter dateFromString:dateStr];
            
            [self setCreatedAt:date];
            [dateFormatter release];
        } else if ([key isEqualToString:@"updated_at"]) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *dateStr = (NSString *)value;
            dateStr = [dateStr stringByReplacingOccurrencesOfString:@"T" withString:@" "];
            dateStr = [dateStr stringByReplacingOccurrencesOfString:@"Z" withString:@""];
            NSDate *date = [dateFormatter dateFromString:dateStr];
            
            [self setUpdatedAt:date];
            [dateFormatter release];
        } else if ([key isEqualToString:@"id"]) {
            [self setIdentifier:value];
        }
    }
}

-(void)dealloc {
    [variants release];
    [images release];
    [tags release];
    [title release];
    [handle release];
    [vendor release];
    [bodyHTML release];
    [productType release];
    [publishedAt release];
    [super dealloc];
}


@end
