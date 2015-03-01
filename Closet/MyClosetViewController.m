//
//  MyClosetViewController.m
//  Closet
//
//  Created by Adam Cooper on 2/28/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import "MyClosetViewController.h"
#import "MyClosetManager.h"
#import "MyClosetTableViewCell.h"
#import "RecomendationsTableViewCell.h"
#import <TwitterKit/TwitterKit.h>

@interface MyClosetViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *recomendationsTableView;

@property BOOL closetIsShowing;

@end


typedef NS_ENUM(NSUInteger, TableView){
    FavoritesTableView,
    MyClosetTableView
};

@implementation MyClosetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.closetIsShowing = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyClosetTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[MyClosetTableViewCell reuseidentifier]];
    
    
    [self.recomendationsTableView registerNib:[UINib nibWithNibName:@"RecomendationsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[RecomendationsTableViewCell reusidentifier]];

    
//        if (![[Digits sharedInstance] session].phoneNumber) {
//            [self performSegueWithIdentifier:@"LoginViewSegue" sender:self];
//        }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSwitchViewButtonPressed:(UIBarButtonItem*)sender {
    
    if (self.tableView.alpha == 0) {
        
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.tableView.alpha = 1;
            [sender setImage:[UIImage imageNamed:@"stars_icon"]];


        } completion:^(BOOL finished) {
            [self.tableView reloadData];
        }];

//
    } else {
        
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            self.tableView.alpha = 0;
            [sender setImage:[UIImage imageNamed:@"closet_icon"]];
        } completion:^(BOOL finished) {
            [self.recomendationsTableView reloadData];
            
        }];

//        [UIView transitionFromView:self.recomendationsTableView toView:self.tableView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
//            self.closetIsShowing = NO;
//            [self.tableView reloadData];
//        }];

    }
}



#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([tableView isEqual:self.tableView]) {
        return 60;
    } else {
        return self.tableView.frame.size.width;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if([tableView isEqual:self.tableView]) {
        return [MyClosetManager sharedClient].closetItems.count;
    } else {
        return 20;
    }
    return 10;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([tableView isEqual:self.tableView]) {
        MyClosetTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[MyClosetTableViewCell reuseidentifier] forIndexPath:indexPath];
        return cell;
    } else {
        RecomendationsTableViewCell *cell = [self.recomendationsTableView dequeueReusableCellWithIdentifier:[RecomendationsTableViewCell reusidentifier] forIndexPath:indexPath];
        return cell;
    }
    
    return nil;
    
}



@end
