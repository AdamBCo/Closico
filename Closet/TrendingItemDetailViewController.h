//
//  RecomendationDetailViewController.h
//  Closet
//
//  Created by Adam Cooper on 3/1/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASOTwoStateButton.h"
#import "ASOBounceButtonViewDelegate.h"
#import "BounceButtonView.h"
#import "Item.h"

@interface TrendingItemDetailViewController : UIViewController <ASOBounceButtonViewDelegate>

@property (strong, nonatomic) IBOutlet ASOTwoStateButton *menuButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (strong, nonatomic) BounceButtonView *menuItemView;
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UILabel *brandName;
@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UIImageView *brandImageView;

@property Item *selectedItem;


- (IBAction)menuButtonAction:(id)sender;
- (IBAction)onCloseButtonPressed:(id)sender;

@end
