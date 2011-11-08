//
//  BYCartViewController.h
//  Restaurantify
//
//  Created by Will Fairclough on 11-11-08.
//  Copyright (c) 2011 Boneyard Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYCartViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSURLRequest *urlRequest;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andURLRequest:(NSURLRequest *)request;

@end
