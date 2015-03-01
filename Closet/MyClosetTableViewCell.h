//
//  MyClosetTableViewCell.h
//  Closet
//
//  Created by Adam Cooper on 2/28/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyClosetTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *clothingIcon;
@property (weak, nonatomic) IBOutlet UILabel *clothingTitle;
+(NSString *)reuseidentifier;

@end
