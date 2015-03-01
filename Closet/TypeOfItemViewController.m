//
//  TypeOfItemViewController.m
//  Closet
//
//  Created by Adam Cooper on 2/27/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import "TypeOfItemViewController.h"
#import "BrandTableViewController.h"
#import "TOIDetailCollectionViewCell.h"

@interface TypeOfItemViewController ()
<
UITableViewDelegate, UITableViewDataSource,
UICollectionViewDelegate, UICollectionViewDataSource
>

@property (weak, nonatomic) IBOutlet UITableView *TOITableView;
@property (weak, nonatomic) IBOutlet UICollectionView *TOICollectionView;

@property NSArray *tops;
@property NSArray *bottoms;
@property NSArray *skirts;
@property NSArray *dresses;
@property NSArray *bags;
@property NSArray *shoes;


@end

@implementation TypeOfItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    
    self.tops = @[@{@"categoryName": @"T-Shirt",@"categoryID":@"12345",@"categoryIcon":@"tShirtIcon"},
                  @{@"categoryName": @"Sleeveless",@"categoryID":@"12345",@"categoryIcon":@"sleevelessIcon"},
                  @{@"categoryName": @"Long Sleeve",@"categoryID":@"12345",@"categoryIcon":@"longSleeveIcon"},
                  @{@"categoryName": @"Tank Tops",@"categoryID":@"12345",@"categoryIcon":@"tankTopIcon"},
                  @{@"categoryName": @"Blouses",@"categoryID":@"12345",@"categoryIcon":@"blouseIcon"},
                  @{@"categoryName": @"Bralets",@"categoryID":@"12345",@"categoryIcon":@"braletIcon"}];
    
//    self.bottoms = @[@{@"categoryName": @"",@"categoryID":@"",@"categoryIcon":@""}
//                    @{@"categoryName": @"",@"categoryID":@"",@"categoryIcon":@""}
//                    @{@"categoryName": @"",@"categoryID":@"",@"categoryIcon":@""}
//                    @{@"categoryName": @"",@"categoryID":@"",@"categoryIcon":@""}
//                    @{@"categoryName": @"",@"categoryID":@"",@"categoryIcon":@""}
//                    @{@"categoryName": @"",@"categoryID":@"",@"categoryIcon":@""}
//                    ];
//    
    
    

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Segue Delegates

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    BrandTableViewController *destinationViewController = segue.destinationViewController;
    destinationViewController.selectedProductID = @"44717";
}

#pragma mark - TableViewDataSource & TableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TOICell"];
    cell.textLabel.text = @"Item";
    return cell;
}

#pragma mark = CollectionViewDataSource & CollectionViewDelegate


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"BrandViewSegue" sender:self];
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.tops.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *item = [self.tops objectAtIndex:indexPath.section];
    TOIDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TOIDetailCell" forIndexPath:indexPath];
    cell.iconTitleView.text = [item objectForKey:@"categoryName"];
    cell.iconImageView.image = [UIImage imageNamed:[item objectForKey:@"categoryIcon"]];
    
    return cell;
}

@end
