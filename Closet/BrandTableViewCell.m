//
//  ClosetItemTableViewCell.m
//  Closet
//
//  Created by Adam Cooper on 2/27/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import "BrandTableViewCell.h"

@implementation BrandTableViewCell

+(NSString *)reuseIdentifier{
    return @"ClosetItemCell";
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
