//
//  LLStoreWrapper.h
//  Lifelapse
//
//  Created by Glenn Wolters on 5/10/11.
//  Copyright 2011 OMGWTFBBQ All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"

@class LLStoreWrapper;
@protocol LLStoreDelegate <NSObject>

// Products
-(void)storeWrapper:(LLStoreWrapper *)storeWrapper finishedGettingProducts:(NSArray *)products;
-(void)storeWrapper:(LLStoreWrapper *)storeWrapper failedGettingProducts:(NSDictionary *)failure;

// Orders
-(void)storeWrapper:(LLStoreWrapper *)storeWrapper finishedGettingOrders:(NSArray *)orders;
-(void)storeWrapper:(LLStoreWrapper *)storeWrapper failedGettingOrders:(NSDictionary *)failure;

// Cart
-(void)storeWrapper:(LLStoreWrapper *)storeWrapper finishedAddingItemToCart:(NSString *)successMsg;
-(void)storeWrapper:(LLStoreWrapper *)storeWrapper failedAddingItemToCart:(NSDictionary *)failure;

@end


@interface LLStoreWrapper : NSObject {
	id<LLStoreDelegate> delegate;

	ASIHTTPRequest *request_;
	
}

@property (assign) id<LLStoreDelegate> delegate;


-(void)getProducts;

-(void)getOrders;

-(void)addItemToCart:(NSString *)itemID;

-(void)cancelRequest;

@end
