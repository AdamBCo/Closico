//
//  RecomendationDetailViewController.m
//  Closet
//
//  Created by Adam Cooper on 3/1/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import "TrendingItemDetailViewController.h"


@interface TrendingItemDetailViewController ()

@end

@implementation TrendingItemDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.menuButton initAnimationWithFadeEffectEnabled:YES];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *menuItemsVC = (UIViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"ExpandMenu"];
    self.menuItemView = (BounceButtonView *)menuItemsVC.view;
    
    NSArray *arrMenuItemButtons = [[NSArray alloc] initWithObjects:self.menuItemView.menuItem1,
                                   self.menuItemView.menuItem2,
                                   self.menuItemView.menuItem3,
                                   self.menuItemView.menuItem4,
                                   nil]; // Add all of the defined 'menu item button' to 'menu item view'
    [self.menuItemView addBounceButtons:arrMenuItemButtons];
    
    // Set the bouncing distance, speed and fade-out effect duration here. Refer to the ASOBounceButtonView public properties
    [self.menuItemView setBouncingDistance:[NSNumber numberWithFloat:0.7f]];
    
    // Set as delegate of 'menu item view'
    [self.menuItemView setDelegate:self];
    
    self.closeButton.layer.cornerRadius = self.closeButton.frame.size.width/2;
    
    self.detailImageView.image = [UIImage imageWithData:self.selectedItem.standardResolutionImageData];
    self.brandName.text = self.selectedItem.brand;
    self.itemName.text = self.selectedItem.name;
    [self.itemName sizeToFit];
}

-(void)viewDidAppear:(BOOL)animated{
    [self.menuItemView setAnimationStartFromHere:self.menuButton.frame];
    self.menuItemView.menuItem1.layer.cornerRadius = self.menuItemView.menuItem1.frame.size.width/2;
    self.menuItemView.menuItem2.layer.cornerRadius = self.menuItemView.menuItem2.frame.size.width/2;
    self.menuItemView.menuItem3.layer.cornerRadius = self.menuItemView.menuItem3.frame.size.width/2;
    self.menuItemView.menuItem4.layer.cornerRadius = self.menuItemView.menuItem4.frame.size.width/2;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)menuButtonAction:(id)sender{
    
    if ([sender isOn]) {
        // Show 'menu item view' and expand its 'menu item button'
        [self.menuButton addCustomView:self.menuItemView];
        [self.menuItemView expandWithAnimationStyle:ASOAnimationStyleExpand];
    }
    else {
        // Collapse all 'menu item button' and remove 'menu item view'
        [self.menuItemView collapseWithAnimationStyle:ASOAnimationStyleExpand];
        [self.menuButton removeCustomView:self.menuItemView interval:[self.menuItemView.collapsedViewDuration doubleValue]];
    }
}

- (IBAction)onCloseButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark - Menu item view delegate method

- (void)didSelectBounceButtonAtIndex:(NSUInteger)index
{
    // Collapse all 'menu item button' and remove 'menu item view' once a menu item is selected
    [self.menuButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    // Set your custom action for each selected 'menu item button' here
    NSString *alertViewTitle = [NSString stringWithFormat:@"Menu Item %x is selected", (short)index];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertViewTitle message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (void)willAnimateRotationToInterfaceOrientation:
(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    // Update 'menu button' position to 'menu item view' everytime there is a change in device orientation
    [self.menuItemView setAnimationStartFromHere:self.menuButton.frame];
}

@end
