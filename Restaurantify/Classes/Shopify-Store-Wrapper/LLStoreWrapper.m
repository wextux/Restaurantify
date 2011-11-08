//
//  LLStoreWrapper.m
//  Lifelapse
//
//  Created by Glenn Wolters on 5/10/11.
//  Copyright 2011 OMGWTFBBQ All rights reserved.
//

#import "LLStoreWrapper.h"
#import "CJSONDeserializer.h"
#import "BYShopifyProduct.h"
#import "ASIFormDataRequest.h"


@interface LLStoreWrapper ()

-(void)getProductsWithURLString:(NSString *)urlString andReturnType:(NSString *)returnType;

@end
    



@implementation LLStoreWrapper

@synthesize delegate;

// These are credentials created for my Dev Shop. These will not work for every store.
static NSString *APIKey = @"cb3c0912c7b83d215a0220b09cff4533";
static NSString *password = @"238b4a24546cdd87c49b3a73ba1a5404";
static NSString *baseURL = @"zulauf-okon7796.myshopify.com/admin/";
static NSString *returnFormat = @"json";


#pragma mark - Actions
-(void)getProducts {

	NSString *returnType = @"products";
	
	NSString *urlString = [NSString stringWithFormat:@"http://%@:%@@%@%@.%@", APIKey, password, baseURL, returnType, returnFormat];
	NSLog(@"%@", urlString);
	__block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlString]];
	[request setTimeOutSeconds:30];
	[request setNumberOfTimesToRetryOnTimeout:1];
	[request setCompletionBlock:^{
		NSError *error;
		
		if ([delegate respondsToSelector:@selector(storeWrapper:finishedGettingProducts:)]) {
            
            
            NSArray *jsonProducts = [[[CJSONDeserializer deserializer] deserialize:[request responseData] error:&error] objectForKey:returnType];
            NSMutableArray *shopifyProducts = [[NSMutableArray alloc] initWithCapacity:[jsonProducts count]];
            
            for (NSDictionary *product in jsonProducts) {
                BYShopifyProduct *shopifyProduct = [[BYShopifyProduct alloc] initWithDictionary:product];
                [shopifyProducts addObject:shopifyProduct];
                [shopifyProduct release];
            }
			[delegate storeWrapper:self finishedGettingProducts:shopifyProducts];
            [shopifyProducts release];
		}
		
	}];
	[request setFailedBlock:^{
		NSError *error;
		
		if ([delegate respondsToSelector:@selector(storeWrapper:failedGettingProducts:)]) {
			[delegate storeWrapper:self failedGettingProducts:
			 [[CJSONDeserializer deserializer] deserialize:[request responseData] error:&error]];
		}
		
	}];
	request_ = request;
	[request startAsynchronous];
    
    // Memory Management
    [returnType release];
}

-(void)getProductsWithProductType:(NSString *)productType {
    NSString *returnType = @"products";
    NSString *searchStr = [NSString stringWithFormat:@"?product_type=%@",productType];
    NSString *urlString = [NSString stringWithFormat:@"http://%@:%@@%@%@.%@%@", APIKey, password, baseURL, returnType, returnFormat, searchStr];
    
    [self getProductsWithURLString:urlString andReturnType:returnType];
    [returnType release];
}

-(void)getProductsWithURLString:(NSString *)urlString andReturnType:(NSString *)returnType {

	NSLog(@"%@", urlString);
	__block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlString]];
	[request setTimeOutSeconds:30];
	[request setNumberOfTimesToRetryOnTimeout:1];
	[request setCompletionBlock:^{
		NSError *error;
		
		if ([delegate respondsToSelector:@selector(storeWrapper:finishedGettingProducts:)]) {
            
            
            NSArray *jsonProducts = [[NSArray alloc] init];
            jsonProducts = [NSArray arrayWithArray:[[[CJSONDeserializer deserializer] deserialize:[request responseData] error:&error] objectForKey:returnType]];
            NSMutableArray *shopifyProducts = [[NSMutableArray alloc] initWithCapacity:[jsonProducts count]];
            
            for (NSDictionary *product in jsonProducts) {
                BYShopifyProduct *shopifyProduct = [[BYShopifyProduct alloc] initWithDictionary:product];
                [shopifyProducts addObject:shopifyProduct];
                [shopifyProduct release];
            }
			[delegate storeWrapper:self finishedGettingProducts:shopifyProducts];
            [shopifyProducts release];
		}
		
	}];
	[request setFailedBlock:^{
		NSError *error;
		
		if ([delegate respondsToSelector:@selector(storeWrapper:failedGettingProducts:)]) {
			[delegate storeWrapper:self failedGettingProducts:
			 [[CJSONDeserializer deserializer] deserialize:[request responseData] error:&error]];
		}
		
	}];
	request_ = request;
	[request startAsynchronous];
    
}



-(void)getOrders {

	NSString *returnType = @"orders";
	
	NSString *urlString = [NSString stringWithFormat:@"http://%@:%@@%@%@.%@", APIKey, password, baseURL, returnType, returnFormat];
	
	__block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
	[request setTimeOutSeconds:30];
	[request setStringEncoding:NSUTF8StringEncoding];
	[request setNumberOfTimesToRetryOnTimeout:1];
	[request setCompletionBlock:^{
		NSError *error;
		
		if ([delegate respondsToSelector:@selector(storeWrapper:finishedGettingOrders:)]) {
			[delegate storeWrapper:self finishedGettingOrders:
			 [[[CJSONDeserializer deserializer] deserialize:[request responseData] error:&error] objectForKey:returnType]];
		}
		
	}];
	[request setFailedBlock:^{
		NSError *error;
		
		if ([delegate respondsToSelector:@selector(storeWrapper:failedGettingOrders:)]) {
			[delegate storeWrapper:self failedGettingOrders:
			 [[CJSONDeserializer deserializer] deserialize:[request responseData] error:&error]];
		}
		
	}];
	request_ = request;
	[request startAsynchronous];
    
}

-(void)addItemToCart:(NSNumber *)itemID {

    NSString *urlString = @"http://zulauf-okon7796.myshopify.com/cart/add/";
    
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[NSString stringWithFormat:@"%@", itemID] forKey:@"id"];
	[request setTimeOutSeconds:30];
	[request setNumberOfTimesToRetryOnTimeout:1];

	[request setCompletionBlock:^{
		if ([delegate respondsToSelector:@selector(storeWrapperFinishedAddingItemToCart:withRequest:)]) {
            [delegate storeWrapperFinishedAddingItemToCart:self withRequest:request];
		}
		
	}];
	[request setFailedBlock:^{
		NSError *error;
		
        error = [request error];
        NSLog(@"ERROR: %@",error);
	}];

    formDataRequest_ = request;
	[request startAsynchronous];
    //[request release];
}



-(void)cancelRequest {
	[request_ clearDelegatesAndCancel];
}

-(void)dealloc {
    [APIKey release];
    [baseURL release];
    [password release];
    [returnFormat release];
    [super dealloc];
}

@end
