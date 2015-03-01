//
//  LoginViewController.m
//  Closet
//
//  Created by Adam Cooper on 2/27/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import "LoginViewController.h"
#import <TwitterKit/TwitterKit.h>
#import <Firebase/Firebase.h>
#import "User.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Twitter Digits Setup.
    
    
//    Firebase *fireBase = [[Firebase alloc] initWithUrl:@"https://torrid-heat-6978.firebaseio.com"];
    
    
    DGTAuthenticateButton *authenticateButton = [DGTAuthenticateButton buttonWithAuthenticationCompletion:^(DGTSession *session, NSError *error) {
        
//        NSDictionary *userInfo = @{
//                                 @"oauth_token" : session.authToken,
//                                 @"oauth_token_secret": session.authTokenSecret,
//                                 @"user_id":session.userID
//                                 };
//        
//        NSLog(@"USERINFO: %@",userInfo);
//        
//        [fireBase authWithOAuthProvider:@"twitter" parameters:userInfo
//               withCompletionBlock:^(NSError *error, FAuthData *authData) {
//                   NSLog(@"Error: %@? or Auth Data: %@?", error, authData);
//               }];
        
        
        [self dismissViewControllerAnimated:YES completion:nil];
        NSLog(@"The has logged in.");

    }];
    
    authenticateButton.center = CGPointMake(self.view.center.x, self.view.frame.size.height*.9);
    [self.view addSubview:authenticateButton];
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
