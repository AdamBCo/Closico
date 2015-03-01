//
//  MyClosetTableViewCell.m
//  Closet
//
//  Created by Adam Cooper on 2/28/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import "MyClosetTableViewCell.h"

@implementation MyClosetTableViewCell

+(NSString *)reuseidentifier{
    return @"MyClosetTableViewCell";
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
