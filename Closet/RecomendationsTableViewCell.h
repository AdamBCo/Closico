//
//  RecomendationsTableViewCell.h
//  Closet
//
//  Created by Adam Cooper on 2/28/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recomendation.h"

@protocol RecomendationCellDelgate <NSObject>

-(void)profileViewTapped: (NSString *)username;
-(void)onItemImageViewTapped: (Recomendation *)recomendation;
-(void)onItemImageViewPressed: (Recomendation *)recomendation;
//-(void)onShareButtonPressed: (InstagramPhoto *)instagramPhoto;

@end

@interface RecomendationsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *brandName;
@property (weak, nonatomic) IBOutlet UIImageView *brandImageView;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (weak, nonatomic) IBOutlet UIView *toolbarView;
@property (weak, nonatomic) IBOutlet UIView *brandProfileView;

@property id<RecomendationCellDelgate> delegate;

+(NSString *)reusidentifier;

@end
