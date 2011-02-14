//
//  LoginFooterViewController.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/9/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class O2Request;
@class SignUp;
@class User;

@interface WelcomeFooter : UIViewController {
	O2Request *request;
	SignUp *signUpView;
	UITabBarController *tabBar;
    User *user;
}

@property (nonatomic, retain) User *user;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) SignUp *signUpView;
@property (nonatomic, retain) UITabBarController *tabBar;

- (IBAction) login:(id)sender;
- (void) loginResponse;
- (IBAction) gotoSignUp:(id)sender;
- (void) gotoDashboard;
- (void) loginError;

@end
