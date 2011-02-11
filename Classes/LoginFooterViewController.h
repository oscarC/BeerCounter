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
@class HomeViewController;

@interface LoginFooterViewController : UIViewController {
	O2Request *request;
	SignUpTableViewController *signUpView;
	HomeViewController *homeView;
}

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) SignUpTableViewController *signUpView;
@property (nonatomic, retain) HomeViewController *homeView;

- (IBAction) login:(id)sender;
- (void) loginResponse;
- (IBAction) gotoSignUp:(id)sender;
- (void) gotoDashboard;

@end
