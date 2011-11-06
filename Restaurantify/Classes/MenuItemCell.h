//
//  MenuItemCell.h
//  Restaurantify
//
//  Created by Will Fairclough on 11-11-05.
//  Copyright (c) 2011 Superna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuItemCell : UITableViewCell {
//BOOL useDarkBackground;
}
//
//@property BOOL useDarkBackground;
@property (nonatomic, strong) IBOutlet UILabel *textLabel;
@property (nonatomic, strong) IBOutlet UITextView *detailLabel;
@property (nonatomic, strong) IBOutlet UIImageView *thumbnailImage;

@end
