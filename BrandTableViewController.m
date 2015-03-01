//
//  MainTableViewController.m
//  Closet
//
//  Created by Adam Cooper on 2/27/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import "BrandTableViewController.h"
#import "BrandTableViewCell.h"
#import "Item.h"
#import "Brand.h"
#import "MacysAPIClient.h"
#import "PossibleItemsViewController.h"

@interface BrandTableViewController ()
@property MacysAPIClient *macysAPIClient;
@property NSString *selectedDesigner;

@end

@implementation BrandTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.macysAPIClient = [MacysAPIClient sharedClient];
    [self.macysAPIClient downloadBrandsFor:self.selectedProductID withCompletion:^{
        [self.tableView reloadData];
    }];

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)createNewClosetItem {
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    PossibleItemsViewController *destinationViewController = segue.destinationViewController;
    destinationViewController.categoryID = self.selectedProductID;
    destinationViewController.designerName = self.selectedDesigner;
    
}




#pragma mark - Table view data source


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Brand *selectedBrand = [self.macysAPIClient.brands objectAtIndex:indexPath.row];
    self.selectedDesigner = selectedBrand.brandName;
    [self performSegueWithIdentifier:@"PossibleItemsSegue" sender:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.macysAPIClient.brands.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Brand *brand = [self.macysAPIClient.brands objectAtIndex:indexPath.row];
    BrandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BrandTableViewCell reuseIdentifier]];
    cell.textLabel.text = brand.brandName;
    
    return cell;
}

@end
