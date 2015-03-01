//
//  MainRecomendationsTableViewController.m
//  Closet
//
//  Created by Adam Cooper on 2/27/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import "MainRecomendationsTableViewController.h"
#import "RecomendationsTableViewCell.h"
#import "RESideMenu.h"
#import "MyClosetManager.h"

@interface MainRecomendationsTableViewController () <RESideMenuDelegate>

@end

@implementation MainRecomendationsTableViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    

    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RecomendationsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[RecomendationsTableViewCell reusidentifier]];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [MyClosetManager sharedClient].closetItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecomendationsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[RecomendationsTableViewCell reusidentifier] forIndexPath:indexPath];
    
    return cell;
}

@end
