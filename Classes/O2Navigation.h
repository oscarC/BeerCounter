//
//  O2Navigation.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/17/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class User;
@class Welcome;
@class StartDrinking;

@interface O2Navigation : NSObject {
    UINavigationController *navController;
    UITabBarController *tabBar;
    User *user;
    Welcome *welcome;
    StartDrinking *startDrinking;
}

@property (nonatomic, retain) UINavigationController *navController;
@property (nonatomic, retain) UITabBarController *tabBar;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) Welcome *welcome;
@property (nonatomic, retain) StartDrinking *startDrinking;

+ (O2Navigation *) navigation:(User *)user;
- (void) gotoSignUp;
- (void) gotoSocialSignUp;
- (void) gotoDashboard;
- (void) gotoFollowingList;
- (void) gotoStartDrinking;
- (void) gotoDrinkList;
- (void) gotoPlaceList;
- (void) updateDashboard;
- (void) backWelcome;
- (void) backStartDrinking;
- (void) dealloc;

@end
