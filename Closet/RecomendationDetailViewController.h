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

@interface RecomendationDetailViewController : UIViewController <ASOBounceButtonViewDelegate>

@property (strong, nonatomic) IBOutlet ASOTwoStateButton *menuButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (strong, nonatomic) BounceButtonView *menuItemView;

- (IBAction)menuButtonAction:(id)sender;
- (IBAction)onCloseButtonPressed:(id)sender;

@end
