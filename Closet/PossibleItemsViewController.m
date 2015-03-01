//
//  PossibleItemsViewController.m
//  Closet
//
//  Created by Adam Cooper on 2/28/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import "PossibleItemsViewController.h"
#import "MacysAPIClient.h"

@interface PossibleItemsViewController ()
@property MacysAPIClient *macysAPIClient;
@property NSArray *possibleItems;

@end

@implementation PossibleItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.macysAPIClient = [MacysAPIClient sharedClient];
    
    [self.macysAPIClient downloadItemswithBrandID:@"Jeans" andDesigner:self.designerName withCompletion:^(NSArray *items) {
        NSLog(@"Item: %@",items);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
