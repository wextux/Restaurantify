//
//  LLStoreWrapper.m
//  Lifelapse
//
//  Created by Glenn Wolters on 5/10/11.
//  Copyright 2011 OMGWTFBBQ All rights reserved.
//

#import "LLStoreWrapper.h"


@implementation LLStoreWrapper

@synthesize delegate;

static NSString *APIKey = @"APIKEY";
static NSString *password = @"PASSWORD";
static NSString *baseURL = @"YOURSTORENAME.myshopify.com/admin/";
static NSString *returnFormat = @"json";

-(void)getProducts {
	NSString *returnType = @"products";
	
	NSString *urlString = [NSString stringWithFormat:@"http://%@:%@@%@%@.%@", APIKey, password, baseURL, returnType, returnFormat];
	
	__block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
	[request setTimeOutSeconds:30];
	[request setStringEncoding:NSUTF8StringEncoding];
	[request setNumberOfTimesToRetryOnTimeout:1];
	[request setCompletionBlock:^{
		NSError *error;
		
		if ([delegate respondsToSelector:@selector(storeWrapper:finishedGettingProducts:)]) {
			[delegate storeWrapper:self finishedGettingProducts:
			 [[[CJSONDeserializer deserializer] deserialize:[request responseData] error:&error] objectForKey:returnType]];
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

-(void)cancelRequest {
	[request_ clearDelegatesAndCancel];
}

@end
