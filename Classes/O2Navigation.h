//
//  O2Navigation.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/17/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BeerCounterAppDelegate.h"

@class SignUp;
@class SocialSignUp;
@class TwitterConnect;
@class Home;
@class Counter;

@interface O2Navigation : NSObject {
    UITabBarController *tabBar;
	SignUp *signUpView;
    SocialSignUp *facebookConnectView;
    TwitterConnect *twitterConnectView;
}

@property (nonatomic, retain) UITabBarController *tabBar;
@property (nonatomic, retain) SignUp *signUpView;
@property (nonatomic, retain) SocialSignUp *facebookConnectView;
@property (nonatomic, retain) TwitterConnect *twitterConnectView;

+ (O2Navigation *) navigation;
- (void) gotoSignUp;
- (void) gotoSocialSignUp;
- (void) gotoTwitterConnect;
- (void) gotoDashboard;
- (void) backWelcome;
- (void) dealloc;

@end
