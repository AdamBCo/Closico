//
//  MyClosetViewController.m
//  Closet
//
//  Created by Adam Cooper on 2/28/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import "MyClosetViewController.h"
#import "MyClosetManager.h"
#import "TrendingItemsManager.h"
#import "MyClosetTableViewCell.h"
#import "TrendingTableViewCell.h"
#import <TwitterKit/TwitterKit.h>
#import "SCLAlertView.h"
#import "TrendingItemDetailViewController.h"
#import "Item.h"
#import "TypeOfItemViewController.h"

@interface MyClosetViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *recomendationsTableView;

@property Item *selectedItem;
@property (weak, nonatomic) IBOutlet UIButton *addNewItemButton;
@property (weak, nonatomic) IBOutlet UIButton *optionSwitchButton;

@property BOOL closetIsShowing;

@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfig;
@property (nonatomic, strong) NSURLSession *session;


@property NSArray *typesOfClothes;

@end


typedef NS_ENUM(NSUInteger, TableView){
    FavoritesTableView,
    MyClosetTableView
};

@implementation MyClosetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.closetIsShowing = YES;
    
    self.sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.session = [NSURLSession sessionWithConfiguration:self.sessionConfig delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    [[TrendingItemsManager sharedClient] downloadItemswithSearchTerm:@"dress" andImageWidth:[UIScreen mainScreen].applicationFrame.size.width withCompletion:^{
        [self.recomendationsTableView reloadData];
    }];
    
    self.typesOfClothes = @[@"Tops",@"Bottoms",@"Dresses",@"Shoes",@"Accessories"];
    
    
    

    [self.tableView registerNib:[UINib nibWithNibName:@"MyClosetTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[MyClosetTableViewCell reuseidentifier]];
    
    
    [self.recomendationsTableView registerNib:[UINib nibWithNibName:@"TrendingTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[TrendingTableViewCell reusidentifier]];
    
    

    self.addNewItemButton.layer.cornerRadius = 15;
//    [self.addNewButton setTintColor:[UIColor whiteColor]];
//    [self.addNewButton addTarget:self action:@selector(onCreateNewItemButtonPressed) forControlEvents:UIControlEventTouchUpInside];
//    [self.addButtonView addSubview:self.addNewButton];
    
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([[Digits sharedInstance] session].phoneNumber) {
        [self performSegueWithIdentifier:@"LoginViewSegue" sender:self];
    }

}

- (IBAction)onCreateNewItemButtonPressed:(id)sender {
    
    [self performSegueWithIdentifier:@"CreateItemSegue" sender:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)onSwitchViewButtonPressed:(UIButton*)sender {
    
    if (self.tableView.alpha == 0) {
        
        [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.tableView.alpha = 1;
            [sender setImage:[UIImage imageNamed:@"stars_icon"] forState:UIControlStateNormal];
            self.title = @"Closet";
            
        } completion:^(BOOL finished) {
            [self.tableView reloadData];
        }];

//
    } else {
        
        [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            self.tableView.alpha = 0;
            [sender setImage:[UIImage imageNamed:@"closet_icon"] forState:UIControlStateNormal];

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
    
    if([tableView isEqual:self.tableView]) {
        NSLog(@"HELLO WORLD!");
    } else {
        self.selectedItem = [[TrendingItemsManager sharedClient].trendingItems objectAtIndex:indexPath.section];
        [self performSegueWithIdentifier:@"DetailViewSegue" sender:self];
    }
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
        return self.typesOfClothes.count;
    } else {
        return [TrendingItemsManager sharedClient].trendingItems.count;
    }
    return 10;;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

        if ([segue.identifier isEqualToString:@"DetailViewSegue"]) {

            TrendingItemDetailViewController *destinationViewController = segue.destinationViewController;
            destinationViewController.selectedItem = self.selectedItem;
        } else if ([segue.identifier isEqualToString:@"CreateItemSegue"]) {
            
            TypeOfItemViewController *destinationViewController = segue.destinationViewController;
        }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([tableView isEqual:self.tableView]) {
        MyClosetTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[MyClosetTableViewCell reuseidentifier] forIndexPath:indexPath];
        cell.clothingTitle.text = [self.typesOfClothes objectAtIndex:indexPath.section];
        
        if (indexPath.section == 0) {
            
            cell.clothingIcon.image = [UIImage imageNamed:@"shirt_Icon"];
            
        } else if (indexPath.section == 1) {
            
            cell.clothingIcon.image = [UIImage imageNamed:@"bottoms_icon"];
            
        } else if (indexPath.section == 2) {
            
            cell.clothingIcon.image = [UIImage imageNamed:@"dress_icon"];
            
        }else if (indexPath.section == 3) {
            cell.clothingIcon.image = [UIImage imageNamed:@"female_shoe"];
            
        }else if (indexPath.section == 4) {
            cell.clothingIcon.image = [UIImage imageNamed:@"accessories_icon"];
            
        }else if (indexPath.section == 5) {
            
        }
        
        return cell;
    } else {
        Item *item = [[TrendingItemsManager sharedClient].trendingItems objectAtIndex:indexPath.section];
        TrendingTableViewCell *cell = [self.recomendationsTableView dequeueReusableCellWithIdentifier:[TrendingTableViewCell reusidentifier] forIndexPath:indexPath];
        cell.brandName.text = item.brand;
        cell.itemName.text = item.name;
        
        
        NSURL *standardImageURL = item.standardResolutonImageURL;
        NSLog(@"URL: %@",standardImageURL);
        NSString *key = standardImageURL.absoluteString;
        
        if (standardImageURL) {
            if ([[TrendingItemsManager sharedClient].itemImageCache objectForKey:key]) {
                cell.itemImageView.image = [[TrendingItemsManager sharedClient].itemImageCache objectForKey:key];
            } else {

        if (cell.standardImageDownloadTask) {
                [cell.standardImageDownloadTask cancel];
        }
        cell.standardImageDownloadTask = [self.session dataTaskWithURL:standardImageURL
                                                     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                         
                                         if (error) {
                                             if([error code] == NSURLErrorCancelled) {
                                                 return;
                                             }else {
                                                 NSLog(@"ERROR: %@", error);
                                             };
                                         } else {
                                             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                             if (httpResponse.statusCode == 200) {
                                                 UIImage *image = [UIImage imageWithData:data];
                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                     
                                                     [[TrendingItemsManager sharedClient].itemImageCache setObject:image forKey:key];
                                                         cell.itemImageView.image = image;
                                                     item.standardResolutionImageData = UIImagePNGRepresentation(image);
                                                 });
                                             } else {
                                                 NSLog(@"Couldn't load image at URL: %@", standardImageURL);
                                                 NSLog(@"HTTP %ld", (long)httpResponse.statusCode);
                                             }
                                         }
                                     }];
            [cell.standardImageDownloadTask resume];
            return cell;
        }
        }
    }
    
    return nil;
    
}

- (IBAction)onSettingsButtonPushed:(id)sender {
    
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];

    //Using Block
    [alert addButton:@"Logout" actionBlock:^(void) {
        NSLog(@"The User has Logged Out");
        [[Digits sharedInstance] logOut];
        [self performSegueWithIdentifier:@"LoginViewSegue" sender:self];
    }];
    
    [alert showSuccess:self title:@"Logout" subTitle:@"Are you sure you would like to logout of the application?" closeButtonTitle:@"Cancel" duration:0.0f];

}


@end
