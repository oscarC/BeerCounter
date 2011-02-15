//
//  LoginFooterViewController.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/9/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@class O2Request;
@class SignUp;
@class User;

@interface WelcomeFooter : UIViewController<FBSessionDelegate, FBRequestDelegate> {
	O2Request *request;
	SignUp *signUpView;
	UITabBarController *tabBar;
    User *user;
}

@property (nonatomic, retain) O2Request *request;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) SignUp *signUpView;
@property (nonatomic, retain) UITabBarController *tabBar;
@property (nonatomic, retain) Facebook *facebook;

- (IBAction) bcLogin:(id)sender;
- (void) bcLoginResponse;
- (IBAction) gotoSignUp:(id)sender;
- (void) gotoDashboard;
- (void) loginError;

- (IBAction) fbLogin:(id)sender;
- (IBAction) fbLogout:(id)sender;

@end
