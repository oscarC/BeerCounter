//
//  TwitterConnect.m
//  BeerCounter
//
//  Created by Oscar De Moya on 2/16/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "TwitterConnect.h"
#import "SA_OAuthTwitterEngine.h"
#import "BeerCounterAppDelegate.h"
#import "AppConfig.h"
#import "O2Authentication.h"
#import "O2Request.h"
#import "O2Navigation.h"

@implementation TwitterConnect

+ (TwitterConnect *) twitterConnect {
    TwitterConnect *twitter = [[TwitterConnect alloc] init];
    [twitter initEngine];
    return twitter;
}

- (void) initEngine {
	if (_engine) return;
	_engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate: self];
	_engine.consumerKey = TW_OAUTH_KEY;
	_engine.consumerSecret = TW_OAUTH_SECRET;
}

//=============================================================================================================================
#pragma mark SA_OAuthTwitterEngineDelegate
- (void) storeCachedTwitterOAuthData:(NSString *)data forUsername:(NSString *)username {
    BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
    O2Authentication *auth = beerCounterDelegate.auth;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *user_id = [auth.request extractValueFromParamString:data withKey:@"user_id"];
    beerCounterDelegate.auth.user.twitter_id = user_id;
	[defaults setObject:data forKey:@"authData"];
	[defaults synchronize];
}

- (NSString *) cachedTwitterOAuthDataForUsername:(NSString *)username {
    BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
    O2Authentication *auth = beerCounterDelegate.auth;
    NSString *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"authData"];
    NSString *user_id = [auth.request extractValueFromParamString:data withKey:@"user_id"];
    beerCounterDelegate.auth.user.twitter_id = user_id;
	return data;
}

- (NSString *) cachedUsername {
    BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
    O2Authentication *auth = beerCounterDelegate.auth;
    NSString *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"authData"];
    NSString *username = [auth.request extractValueFromParamString:data withKey:@"screen_name"];
    NSLog(@"Twitter username: %@", username);
    return username;
}

//=============================================================================================================================
#pragma mark SA_OAuthTwitterControllerDelegate
- (void) OAuthTwitterController:(SA_OAuthTwitterController *)controller authenticatedWithUsername:(NSString *)username {
	NSLog(@"Authenicated for %@", username);
    BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
    [beerCounterDelegate.auth bcTwLogin];
}

- (void) OAuthTwitterControllerFailed:(SA_OAuthTwitterController *)controller {
	NSLog(@"Authentication Failed!");
}

- (void) OAuthTwitterControllerCanceled:(SA_OAuthTwitterController *)controller {
	NSLog(@"Authentication Canceled.");
}

//=============================================================================================================================
#pragma mark TwitterEngineDelegate
- (void) requestSucceeded:(NSString *)requestIdentifier {
	NSLog(@"Request %@ succeeded", requestIdentifier);
}

- (void) requestFailed:(NSString *)requestIdentifier withError:(NSError *)error {
	NSLog(@"Request %@ failed with error: %@", requestIdentifier, error);
}

//=============================================================================================================================
- (UIViewController *)controller {
    return [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine:_engine delegate:self];
}

- (void)logout {
    [_engine clearAccessToken];
}

- (BOOL)isAuthorized {
    return [_engine isAuthorized];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [_engine release];
    [super dealloc];
}

@end
