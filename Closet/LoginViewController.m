//
//  LoginViewController.m
//  Closet
//
//  Created by Adam Cooper on 2/27/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import "LoginViewController.h"
#import <TwitterKit/TwitterKit.h>
#import "User.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Twitter Digits Setup.
    
    DGTAuthenticateButton *authenticateButton = [DGTAuthenticateButton buttonWithAuthenticationCompletion:^(DGTSession *session, NSError *error) {
        NSLog(@"The user logged in");

    }];
    
    [self.view addSubview:authenticateButton];
    authenticateButton.center = self.view.center;

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
