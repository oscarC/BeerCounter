//
//  LoginFooterViewController.m
//  BeerCounter
//
//  Created by Oscar De Moya on 2/9/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "WelcomeFooter.h"
#import "SignUp.h"
#import "Home.h"
#import "BeerCounterAppDelegate.h"
#import "O2Request.h"
#import "User.h"

@implementation WelcomeFooter

@synthesize user, username, password;
@synthesize signUpView, tabBar;

- (IBAction) login:(id)sender {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"LoginStart" object:self];
	NSMutableDictionary *data = [NSMutableDictionary dictionary];
	[data setObject:self.username forKey:@"email"];
	[data setObject:self.password forKey:@"password"];
	[request post:@"User/authenticate" withData:data];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginResponse) name:@"O2RequestFinished" object:request];
}

- (void) loginResponse {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"LoginEnd" object:self];
	NSDictionary *data = [request data];
    self.user.email = username;
    self.user.password = password;
    if([data count] > 0) {
        self.user.user_id = [data objectForKey:@"id"];
        self.user.nickname = [data objectForKey:@"nickname"];
        self.user.twitter_id = [data objectForKey:@"twitter_id"];
        self.user.facebook_id = [data objectForKey:@"facebook_id"];
        self.user.drinking = (bool)[data objectForKey:@"drinking"];
        self.user.logged = YES;
        [self gotoDashboard];
    } else {
        self.user.logged = NO;
    }
}

- (IBAction) gotoSignUp:(id)sender {
	SignUp *_signUpView = [[SignUp alloc] initWithNibName:@"SignUp" bundle:nil];
	BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
	self.signUpView = _signUpView;
	[_signUpView release];
	[beerCounterDelegate.navController pushViewController:_signUpView animated:YES];
}

- (void) gotoDashboard {
	BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
	self.tabBar = beerCounterDelegate.tabBar;
    [beerCounterDelegate.navController setNavigationBarHidden:TRUE];
	[beerCounterDelegate.navController pushViewController:tabBar animated:true];
}

- (void) loginError {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginError" object:self];
    BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
	self.tabBar = [beerCounterDelegate tabBar];
	[beerCounterDelegate.navController setNavigationBarHidden:TRUE];
	[beerCounterDelegate.navController pushViewController:tabBar animated:YES];
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	request = [O2Request request];
    self.user = [[User alloc] init];
	username = @"";
	password = @"";
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	// Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [user release];
	[request release];
	[super dealloc];
}


@end
