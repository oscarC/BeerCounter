//
//  SignUpFooterViewController.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/9/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class O2Request;
@class User;
@interface SignUpFooter : UIViewController {
	O2Request *request;
    UITabBarController *tabBar;
    User *user;
}

@property (nonatomic, retain) IBOutlet NSString *email;
@property (nonatomic, retain) IBOutlet NSString *password;
@property (nonatomic, retain) IBOutlet NSString *nickname;
@property (nonatomic, retain) UITabBarController *tabBar;
@property (nonatomic, retain) User *user;

- (IBAction) registerUser:(id)sender;
- (void) registerUserResponse;

@end
