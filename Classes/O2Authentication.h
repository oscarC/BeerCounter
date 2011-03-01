//
//  O2Authentication.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/17/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "FBConnect.h"
#import "TwitterConnect.h"

@class BeerCounterAppDelegate;
@class O2Request;
@class O2Navigation;

@interface O2Authentication : NSObject<FBSessionDelegate, FBRequestDelegate> {
    User *user;
    O2Request *request;
    O2Navigation *navigation;
    TwitterConnect *twitter;
    Facebook *facebook;
}

@property (nonatomic, retain) User *user;
@property (nonatomic, retain) O2Request *request;
@property (nonatomic, retain) O2Navigation *navigation;
@property (nonatomic, retain) TwitterConnect *twitter;
@property (nonatomic, retain) Facebook *facebook;

+ (O2Authentication *) authentication;
- (void) showAlert:(NSString *)errorMsg;
- (void) bcLogin;
- (void) bcLogout;
- (void) bcFbLogin:(NSDictionary *)result;
- (void) bcTwLogin;
- (void) bcLoginResponse;
- (void) fbLogin;
- (void) fbLogout;
- (void) twLogin;
- (void) twLogout;
- (void) twSignUp:(UIViewController *)controller;
- (void) registerUser;
- (void) registerUserResponse;
- (void) dealloc;

@end
