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
	//[request setStringEncoding:NSUTF8StringEncoding];
	[request setNumberOfTimesToRetryOnTimeout:1];
	[request setCompletionBlock:^{
		NSError *error;
		
		if ([delegate respondsToSelector:@selector(storeWrapper:finishedGettingProducts:)]) {
            
            
            NSArray *jsonProducts = [[[CJSONDeserializer deserializer] deserialize:[request responseData] error:&error] objectForKey:returnType];
            NSMutableArray *shopifyProducts = [[NSMutableArray alloc] initWithCapacity:[jsonProducts count]];
            
            for (NSDictionary *product in jsonProducts) {
                BYShopifyProduct *shopifyProduct = [[BYShopifyProduct alloc] initWithDictionary:product];
                [shopifyProducts addObject:shopifyProduct];
            }
			[delegate storeWrapper:self finishedGettingProducts:shopifyProducts];
            //[shopifyProducts release];
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

-(void)addItemToCart:(NSString *)itemID {

    NSString *returnType = @"cart/add";
    NSString *urlString = [NSString stringWithFormat:@"http://%@:%@@%@%@", APIKey, password, baseURL, returnType];
    
    
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setPostValue:itemID forKey:@"id"];
	[request setTimeOutSeconds:30];
	[request setStringEncoding:NSUTF8StringEncoding];
	[request setNumberOfTimesToRetryOnTimeout:1];
	[request setCompletionBlock:^{
		NSError *error;
		
		if ([delegate respondsToSelector:@selector(storeWrapper:finishedAddingItemToCart:)]) {
			[delegate storeWrapper:self finishedGettingOrders:
			 [[[CJSONDeserializer deserializer] deserialize:[request responseData] error:&error] objectForKey:returnType]];
		}
		
	}];
	[request setFailedBlock:^{
		NSError *error;
		
		if ([delegate respondsToSelector:@selector(storeWrapper:failedAddingItemToCart:)]) {
			[delegate storeWrapper:self failedGettingOrders:
			 [[CJSONDeserializer deserializer] deserialize:[request responseData] error:&error]];
		}
		
	}];
    
    request_ = request;
	[request startAsynchronous];

}

-(void)cancelRequest {
	[request_ clearDelegatesAndCancel];
}

@end
