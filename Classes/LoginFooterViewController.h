//
//  LoginFooterViewController.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/9/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class O2Request;
@class SignUpTableViewController;
@class User;

@interface LoginFooterViewController : UIViewController {
	O2Request *request;
	SignUpTableViewController *signUpView;
	UITabBarController *tabBar;
    User *user;
}

@property (nonatomic, retain) User *user;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) SignUpTableViewController *signUpView;
@property (nonatomic, retain) UITabBarController *tabBar;

- (IBAction) login:(id)sender;
- (void) loginResponse;
- (IBAction) gotoSignUp:(id)sender;
- (void) gotoDashboard;
- (void) loginError;

@end
