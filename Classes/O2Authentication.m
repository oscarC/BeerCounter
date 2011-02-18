//
//  O2Authentication.m
//  BeerCounter
//
//  Created by Oscar De Moya on 2/17/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "O2Authentication.h"
#import "BeerCounterAppDelegate.h"
#import "AppConfig.h"
#import "AppGlobal.h"
#import "O2Request.h"
#import "O2Navigation.h"

@implementation O2Authentication

@synthesize user, request, navigation, twitter, facebook;

+ (O2Authentication *) authentication {
    O2Authentication *auth = [[O2Authentication alloc] init];
    auth.user = [[User alloc] init];
    auth.request = [O2Request request];
    auth.navigation = [O2Navigation navigation];
    auth.twitter = [TwitterConnect twitterConnect];
    auth.facebook = [[Facebook alloc] initWithAppId:FB_APP_ID];
    return auth;
}

- (void) showAlert:(NSString *)errorMsg {
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

- (void) bcLogin {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginStart" object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bcLoginResponse) name:@"O2RequestFinished" object:request];
	NSMutableDictionary *data = [NSMutableDictionary dictionary];
	[data setObject:user.username forKey:@"username"];
	[data setObject:user.password forKey:@"password"];
	[request post:@"User/authenticate" withData:data];
}

- (void) bcLogout {
    [twitter logout];
    [facebook logout:self];
    [navigation backWelcome];
}

- (void) bcFbLogin:(NSDictionary *)result {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginStart" object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bcLoginResponse) name:@"O2RequestFinished" object:request];
    BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
    beerCounterDelegate.auth.user.email = [result objectForKey:@"email"];
    beerCounterDelegate.auth.user.facebook_id = [result objectForKey:@"id"];
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject:[result objectForKey:@"id"] forKey:@"facebook_id"];
	[request post:@"User/authenticate" withData:data];
}

- (void) bcTwLogin {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginStart" object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bcLoginResponse) name:@"O2RequestFinished" object:request];
    BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *twitter_id = beerCounterDelegate.auth.user.twitter_id;
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject:twitter_id forKey:@"twitter_id"];
	[request post:@"User/authenticate" withData:data];
}

- (void) bcLoginResponse {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"O2RequestFinished" object:request];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"LoginEnd" object:self];
	NSDictionary *data = [request data];
    BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
    int error_code = [[data objectForKey:@"error_code"] intValue];
    if([data count]>0 && error_code==0) {
        NSDictionary *userinfo = [data objectForKey:@"user"];
        [beerCounterDelegate.auth.user fill:userinfo];
        beerCounterDelegate.auth.user.logged = YES;
        [navigation gotoDashboard];
    } else if(error_code == 102) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginError" object:self];
        [self showAlert:@"You have entered a wrong email or password."];
        beerCounterDelegate.auth.user.logged = NO;
    } else if(error_code == 101 || error_code == 105) {
        [navigation gotoSocialSignUp];
    }
}

// Facebook methods

- (void) fbLogin {
    gSignUpMode = FACEBOOK_CONNECT;
    NSArray *permissions = [[NSArray arrayWithObjects:@"read_stream", @"email", @"offline_access", nil] retain];
    [facebook authorize:permissions delegate:self];
    [permissions release];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bcLoginResponse) name:@"O2RequestFinished" object:self.request];
}

- (void) fbLogout {
    [facebook logout:self];
}

- (void) twLogout {
    [twitter logout];
}

// Facebook delegate methods <FBSessionDelegate>

- (void)fbDidLogin {
    NSLog(@"Facebook login");
    [facebook requestWithGraphPath:@"me" andDelegate:self];
}
- (void)fbDidNotLogin:(BOOL)cancelled {
    NSLog(@"Facebook not login");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"O2RequestFinished" object:request];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginEnd" object:self];
}
- (void)fbDidLogout {
    NSLog(@"Facebook logout");
}

// Facebook delegate methods <FBRequestDelegate>

- (void)requestLoading:(FBRequest *)request { }
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response { }
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error { }
- (void)request:(FBRequest *)request didLoad:(id)result {
    [self bcFbLogin:result];
}

// Registration methods

- (void) registerUser {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RegistrationStart" object:self];
	NSMutableDictionary *data = [NSMutableDictionary dictionary];
    if(gSignUpMode == BEER_COUNTER_SIGNUP) {
        [data setObject:user.email forKey:@"email"];
        [data setObject:user.password forKey:@"password"];
        [data setObject:user.username forKey:@"username"];
    } else if(gSignUpMode == FACEBOOK_CONNECT) {
        [data setObject:user.email forKey:@"email"];
        [data setObject:user.username forKey:@"username"];
        [data setObject:user.facebook_id forKey:@"facebook_id"];
    } else if(gSignUpMode == TWITTER_CONNECT) {
        [data setObject:user.email forKey:@"email"];
        [data setObject:user.username forKey:@"username"];
        [data setObject:user.twitter_id forKey:@"twitter_id"];
    }
	[request post:@"User/signup" withData:data];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc addObserver:self selector:@selector(registerUserResponse) name:@"O2RequestFinished" object:request];
}

- (void) registerUserResponse {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"O2RequestFinished" object:request];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RegistrationEnd" object:self];
	NSDictionary *data = [request data];
    NSLog(@"%@", data);
    int error_code = [[data objectForKey:@"error_code"] intValue];
    NSDictionary *reasons = [data objectForKey:@"reasons"];
    if(error_code == 0) {
        NSDictionary *userinfo = [data  objectForKey:@"user"];
        BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
        [beerCounterDelegate.auth.user fill:userinfo];
        beerCounterDelegate.auth.user.logged = YES;
        [navigation gotoDashboard];
    } else {
        if([reasons objectForKey:@"username"] != nil) {
            [self showAlert:@"Username is already taken."];
        } else if([reasons objectForKey:@"email"] != nil) {
            NSArray *email_reasons = [reasons objectForKey:@"email"];
            int reason_code = [[email_reasons objectAtIndex:0] intValue];
            NSLog(@"%d", reason_code);
            if(reason_code == 104) {
                [self showAlert:@"There's another user registered with the same email."];
            } else if(reason_code == 108) {
                [self showAlert:@"Email has an invalid format."];
            }
        }
    }
}

- (void)dealloc {
    [facebook release];
    [twitter release];
    [navigation release];
    [request release];
    [user release];
	[super dealloc];
}

@end
