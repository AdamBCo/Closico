//
//  TypeOfItemViewController.m
//  Closet
//
//  Created by Adam Cooper on 2/27/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import "TypeOfItemViewController.h"
#import "BrandTableViewController.h"

@interface TypeOfItemViewController ()
<
UITableViewDelegate, UITableViewDataSource,
UICollectionViewDelegate, UICollectionViewDataSource
>

@property (weak, nonatomic) IBOutlet UITableView *TOITableView;
@property (weak, nonatomic) IBOutlet UICollectionView *TOICollectionView;

@end

@implementation TypeOfItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    return 20;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TOIDetailCell" forIndexPath:indexPath];
    return cell;
}

@end
