//
//  RecomendationsTableViewCell.m
//  Closet
//
//  Created by Adam Cooper on 2/28/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import "RecomendationsTableViewCell.h"

@implementation RecomendationsTableViewCell


+(NSString *)reusidentifier{
    return @"RecomendationCell";
}

- (void)awakeFromNib {
    
    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longPressRecognizer.minimumPressDuration = .5;
    [self.itemImageView addGestureRecognizer:longPressRecognizer];
    
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTappedTwice)];
    doubleTapGesture.numberOfTapsRequired = 2;
    [self.itemImageView addGestureRecognizer:doubleTapGesture];
    self.itemImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *profileTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onProfileViewTapped)];
    profileTapGesture.numberOfTapsRequired = 1;
    [self.brandImageView addGestureRecognizer:profileTapGesture];
    self.brandImageView.userInteractionEnabled = YES;
    
    
    self.toolbarView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.toolbarView.layer.shadowOffset = CGSizeMake(0,1);
    self.toolbarView.layer.shadowOpacity = 0.5;
    self.toolbarView.layer.shadowRadius = 1;
    
    self.brandProfileView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.brandProfileView.layer.shadowOffset = CGSizeMake(0,1);
    self.brandProfileView.layer.shadowOpacity = 0.5;
    self.brandProfileView.layer.shadowRadius = 1;

    self.brandImageView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.brandImageView.layer.borderWidth = .5;
    self.brandImageView.layer.cornerRadius = self.brandImageView.frame.size.width/2;


}

-(void)layoutSubviews{
//    CGRect frameRect = self.itemImageView.frame;
//    frameRect.size.height = self.itemImageView.frame.size.width;
//    frameRect.size.width = self.itemImageView.frame.size.width;
//    self.itemImageView.frame = frameRect;
}



-  (void)handleLongPress:(UILongPressGestureRecognizer*)sender {
    if (sender.state == UIGestureRecognizerStateBegan){
        NSLog(@"UIGestureRecognizerStateBegan.");
        [self.delegate onItemImageViewPressed:nil];
    }
}

#pragma mark - Buttons

-(void)onProfileViewTapped {
    [self.delegate profileViewTapped:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
