//
//  O2Navigation.m
//  BeerCounter
//
//  Created by Oscar De Moya on 2/17/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "O2Navigation.h"
#import "AppConfig.h"
#import "AppGlobal.h"
#import "SignUp.h"
#import "SocialSignUp.h"
#import "TwitterConnect.h"
#import "Home.h"
#import "Counter.h"


@implementation O2Navigation

@synthesize tabBar, signUpView, facebookConnectView, twitterConnectView;

+ (O2Navigation *) navigation {
    return [[O2Navigation alloc] init];
}

- (void) gotoSignUp {
    gSignUpMode = BEER_COUNTER_SIGNUP;
	SignUp *_signUpView = [[SignUp alloc] initWithNibName:@"SignUp" bundle:nil];
	BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
	self.signUpView = _signUpView;
	[_signUpView release];
	[beerCounterDelegate.navController pushViewController:self.signUpView animated:true];
}

- (void) gotoSocialSignUp {
	SocialSignUp *_signUpView = [[SocialSignUp alloc] initWithNibName:@"SocialSignUp" bundle:nil];
	BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
	self.facebookConnectView = _signUpView;
	[_signUpView release];
	[beerCounterDelegate.navController pushViewController:self.facebookConnectView animated:true];
}

- (void) gotoTwitterConnect {
    gSignUpMode = TWITTER_CONNECT;
	BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
    [beerCounterDelegate.auth.twitter connect];
}

- (void) gotoDashboard {
	BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
    User *user = beerCounterDelegate.auth.user;
    if(user.drinking) {
        Counter *counter = [[Counter alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:counter];
        counter.title = @"My Drinks";
        NSMutableArray *viewControllers = (NSMutableArray *)beerCounterDelegate.tabBar.viewControllers;
        [viewControllers replaceObjectAtIndex:1 withObject:navController];
        [beerCounterDelegate.tabBar setViewControllers:viewControllers];
        [navController release];
        [counter release];
    }
    self.tabBar = beerCounterDelegate.tabBar;
    [beerCounterDelegate.navController setNavigationBarHidden:true];
	[beerCounterDelegate.navController pushViewController:tabBar animated:true];
}

- (void) backWelcome {
    BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
    [beerCounterDelegate.navController popToViewController:beerCounterDelegate.welcome animated:TRUE];
}

- (void)dealloc {
    [super dealloc];
}

@end
