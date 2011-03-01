//
//  O2Navigation.m
//  BeerCounter
//
//  Created by Oscar De Moya on 2/17/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "O2Navigation.h"
#import "BeerCounterAppDelegate.h"
#import "AppConfig.h"
#import "AppGlobal.h"
#import "TwitterConnect.h"

#import "Welcome.h"
#import "SignUp.h"
#import "SocialSignUp.h"
#import "Home.h"
#import "Counter.h"
#import "FollowingList.h"
#import "StartDrinking.h"
#import "DrinkList.h"
#import "PlaceList.h"


@implementation O2Navigation

@synthesize navController, tabBar, user, welcome, startDrinking;

+ (O2Navigation *) navigation:(User *)user {
    O2Navigation *navigation = [[O2Navigation alloc] init];
    BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
    navigation.navController = beerCounterDelegate.navController;
    navigation.tabBar = beerCounterDelegate.tabBar;
    navigation.user = user;
    
    navigation.welcome = (Welcome *)beerCounterDelegate.navController.topViewController;
    navigation.startDrinking = [[StartDrinking alloc] initWithNibName:@"StartDrinking" bundle:nil];
    return navigation;
}

- (void) gotoSignUp {
    gSignUpMode = BEER_COUNTER_SIGNUP;
    SignUp *viewCtrl = [[SignUp alloc] initWithNibName:@"SignUp" bundle:nil];
	[navController pushViewController:viewCtrl animated:true];
    [viewCtrl release];
}

- (void) gotoSocialSignUp {
	SocialSignUp *viewCtrl = [[SocialSignUp alloc] initWithNibName:@"SocialSignUp" bundle:nil];
	[navController pushViewController:viewCtrl animated:true];
    [viewCtrl release];
}

- (void) gotoDashboard {
    [self updateDashboard];
	[navController pushViewController:tabBar animated:true];
    [navController setNavigationBarHidden:true];
}

- (void) gotoFollowingList {
    NSArray *viewControllers = (NSMutableArray *)tabBar.viewControllers;
    UINavigationController *_navController = [viewControllers objectAtIndex:0];
    FollowingList *viewCtrl = [[FollowingList alloc] initWithNibName:@"FollowingList" bundle:nil];
	[_navController pushViewController:viewCtrl animated:true];
    [viewCtrl release];
}

- (void) gotoStartDrinking {
    NSArray *viewControllers = (NSMutableArray *)tabBar.viewControllers;
    UINavigationController *_navController = [viewControllers objectAtIndex:1];
	[_navController pushViewController:startDrinking animated:true];
}

- (void) gotoDrinkList {
    NSArray *viewControllers = (NSMutableArray *)tabBar.viewControllers;
    UINavigationController *_navController = [viewControllers objectAtIndex:1];
    DrinkList *viewCtrl = [[DrinkList alloc] initWithNibName:@"DrinkList" bundle:nil];
    [_navController pushViewController:viewCtrl animated:YES];
    [viewCtrl release];
}

- (void) gotoPlaceList {
    NSArray *viewControllers = (NSMutableArray *)tabBar.viewControllers;
    UINavigationController *_navController = [viewControllers objectAtIndex:1];
    PlaceList *viewCtrl = [[PlaceList alloc] initWithNibName:@"PlaceList" bundle:nil];
    [_navController pushViewController:viewCtrl animated:YES];
    [viewCtrl release];
}
 
- (void) updateDashboard {
    NSLog(@"Testing 123");
    UIViewController *viewCtrl;
    if(user.drinking) {
        viewCtrl = [[Counter alloc] initWithNibName:@"Counter" bundle:nil];
    } else {
        viewCtrl = [[Home alloc] initWithNibName:@"Home" bundle:nil];
    }
    NSLog(@"Testing 123");
    UINavigationController *_navController = [[UINavigationController alloc] initWithRootViewController:viewCtrl];
    _navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    viewCtrl.title = @"My Drinks";
    NSLog(@"Testing 123");
    NSMutableArray *viewControllers = (NSMutableArray *)tabBar.viewControllers;
    [viewControllers replaceObjectAtIndex:1 withObject:_navController];
    [tabBar setViewControllers:viewControllers];
    [_navController release];
    [viewCtrl release];    
}

- (void) backWelcome {
    [navController setNavigationBarHidden:false];
    [navController popToViewController:welcome animated:true];
}

- (void) backStartDrinking {
    NSArray *viewControllers = (NSMutableArray *)tabBar.viewControllers;
    UINavigationController *_navController = [viewControllers objectAtIndex:1];    
    [_navController popToViewController:startDrinking animated:true];
}

- (void)dealloc {
    [super dealloc];
}

@end
