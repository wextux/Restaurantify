//
//  BYShopifyImage.m
//  Restaurantify
//
//  Created by Will Fairclough on 11-11-05.
//  Copyright (c) 2011 Boneyard Interactive. All rights reserved.
//

#import "BYShopifyImage.h"

@implementation BYShopifyImage
@synthesize position;
@synthesize productId;
@synthesize src;


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if ((self = [self init]) != NULL)
    {
        
        [self setObjectWithDictionary:dictionary];
    }
    return(self);
}

- (void)setObjectWithDictionary:(NSDictionary *)jsonImageDictionary {

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    for (NSString *key in [jsonImageDictionary allKeys]) {
        id value = [jsonImageDictionary objectForKey:key];
        
        if ([key isEqualToString:@"position"]) {
            [self setPosition:value];
        } else if ([key isEqualToString:@"created_at"]) {
            NSString *dateStr = (NSString *)value;
            dateStr = [dateStr stringByReplacingOccurrencesOfString:@"T" withString:@" "];
            dateStr = [dateStr stringByReplacingOccurrencesOfString:@"Z" withString:@""];
            NSDate *date = [dateFormatter dateFromString:dateStr];
            
            [self setCreatedAt:date];
        } else if ([key isEqualToString:@"updated_at"]) {
            NSString *dateStr = (NSString *)value;
            dateStr = [dateStr stringByReplacingOccurrencesOfString:@"T" withString:@" "];
            dateStr = [dateStr stringByReplacingOccurrencesOfString:@"Z" withString:@""];
            NSDate *date = [dateFormatter dateFromString:dateStr];
            
            [self setUpdatedAt:date];
        } else if ([key isEqualToString:@"product_id"]) {
            [self setProductId:value];
        } else if ([key isEqualToString:@"src"]) {
            [self setSrc:value];
        } else if ([key isEqualToString:@"id"]) {
            [self setIdentifier:value];
        }
        
    }
    
    [dateFormatter release];
}


-(void)dealloc {
    [position release];
    [productId release];
    [src release];
    [super dealloc];
}
@end
