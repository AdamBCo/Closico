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
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property UIView *addButtonView;
@property UIButton *addNewButton;

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
    
    
    self.addButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width *.18, self.view.frame.size.width *.18)];
    self.addButtonView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height-30);
    
//    self.addButtonView.backgroundColor = [UIColor colorWithWhite:0.859 alpha:1.000];
    self.addButtonView.layer.cornerRadius = 10;
    [self.navigationController.view addSubview:self.addButtonView];
    
    
    self.addNewButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.addButtonView.frame.size.width*.90, self.addButtonView.frame.size.width*.90)];
    self.addNewButton.center = CGPointMake(self.addButtonView.bounds.size.width/2, self.addButtonView.bounds.size.height/2);
    [self.addNewButton setImage:[UIImage imageNamed:@"plus_icon"] forState:UIControlStateNormal];
    self.addNewButton.backgroundColor = [UIColor colorWithWhite:0.356 alpha:1.000];
    self.addNewButton.layer.cornerRadius = 15;
    [self.addNewButton setTintColor:[UIColor whiteColor]];
    [self.addNewButton addTarget:self action:@selector(onCreateNewItemButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.addButtonView addSubview:self.addNewButton];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;

    
//        if (![[Digits sharedInstance] session].phoneNumber) {
//            [self performSegueWithIdentifier:@"LoginViewSegue" sender:self];
//        }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.addButtonView.alpha == 0) {
        self.addButtonView.alpha = 1;
    }
}

-(void)onCreateNewItemButtonPressed {
    [self performSegueWithIdentifier:@"CreateItemSegue" sender:self];
    self.addButtonView.alpha = 0;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)onSwitchViewButtonPressed:(UIBarButtonItem*)sender {
    
    if (self.tableView.alpha == 0) {
        
        [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.tableView.alpha = 1;
            [sender setImage:[UIImage imageNamed:@"stars_icon"]];
            self.title = @"Closet";


        } completion:^(BOOL finished) {
            [self.tableView reloadData];
        }];

//
    } else {
        
        [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            self.tableView.alpha = 0;
            [sender setImage:[UIImage imageNamed:@"closet_icon"]];
            self.title = @"Recomendations";

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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"DetailViewSegue" sender:self];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([tableView isEqual:self.tableView]) {
        return 60;
    } else {
        return self.tableView.frame.size.width+112;
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }

}

-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([self.recomendationsTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.recomendationsTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.recomendationsTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.recomendationsTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if([tableView isEqual:self.tableView]) {
        return [MyClosetManager sharedClient].closetItems.count;
    } else {
        return 20;
    }
    return 10;;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
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
