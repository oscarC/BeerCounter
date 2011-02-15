//
//  LoginFooterViewController.m
//  BeerCounter
//
//  Created by Oscar De Moya on 2/9/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "WelcomeFooter.h"
#import "AppConfig.h"
#import "SignUp.h"
#import "Home.h"
#import "Counter.h"
#import "BeerCounterAppDelegate.h"
#import "O2Request.h"
#import "User.h"


@implementation WelcomeFooter

<<<<<<< HEAD
@synthesize user, username, password, request, facebook;
=======


@synthesize user, username, password;
>>>>>>> fc2bdcda14e3bc0d1ab40fee0ed3cee1a60dc6a7
@synthesize signUpView, tabBar;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	request = [O2Request request];
    self.user = [[User alloc] init];
	username = @"";
	password = @"";
    facebook = [[Facebook alloc] initWithAppId:FB_API_ID];
}

- (IBAction) fbLogin:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginStart" object:self];
    NSArray *permissions = [[NSArray arrayWithObjects:@"read_stream", @"offline_access", nil] retain];
    [facebook authorize:permissions delegate:self];
    [permissions release];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bcLoginResponse) name:@"O2RequestFinished" object:self.request];
}

- (IBAction) fbLogout:(id)sender {
    [facebook logout:self];
}

// Facebook methods <FBSessionDelegate>

- (void)fbDidLogin {
    NSLog(@"login");
    [facebook requestWithGraphPath:@"me" andDelegate:self];
    NSLog(@"%@", facebook.accessToken);
}
- (void)fbDidNotLogin:(BOOL)cancelled {
    NSLog(@"not login");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"O2RequestFinished" object:request];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NotLogin" object:self];
}
- (void)fbDidLogout {
    NSLog(@"logout");
}

// Facebook methods <FBRequestDelegate>

- (void)requestLoading:(FBRequest *)request {
    
}
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
    
}
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    
}
- (void)request:(FBRequest *)request didLoad:(id)result {
    NSLog(@"%@", result);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bcLoginResponse) name:@"O2RequestFinished" object:self.request];
    NSString *facebook_id = [result objectForKey:@"id"];
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject:facebook_id forKey:@"facebook_id"];
    [self.request post:@"User/authenticate" withData:data];
}
- (void)request:(FBRequest *)request didLoadRawResponse:(NSData *)data {
    NSLog(@"load raw response");
    NSLog(@"%@", data);
}

// BeerCounterServer methods

- (IBAction) bcLogin:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginStart" object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bcLoginResponse) name:@"O2RequestFinished" object:request];
	NSMutableDictionary *data = [NSMutableDictionary dictionary];
	[data setObject:self.username forKey:@"username"];
	[data setObject:self.password forKey:@"password"];
	[request post:@"User/authenticate" withData:data];
}

<<<<<<< HEAD
- (void) bcLoginResponse {
=======

- (void) loginResponse {
>>>>>>> fc2bdcda14e3bc0d1ab40fee0ed3cee1a60dc6a7
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"O2RequestFinished" object:request];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"LoginEnd" object:self];
	NSDictionary *data = [request data];
    self.user.email = username;
    self.user.password = password;
<<<<<<< HEAD
    NSLog(@"%d", [data count]);
    int error_code = [[data objectForKey:@"error_code"] intValue];
    if([data count]>0 && error_code==0) {
        NSDictionary *_user = [data objectForKey:@"user"];
        NSLog(@"%@", _user);
        self.user.user_id = [_user objectForKey:@"id"];
        self.user.nickname = [_user objectForKey:@"nickname"];
        self.user.twitter_id = [_user objectForKey:@"twitter_id"];
        self.user.facebook_id = [_user objectForKey:@"facebook_id"];
        self.user.drinking = (bool)[_user objectForKey:@"drinking"];
        self.user.logged = YES;
        [self gotoDashboard];
=======
    int error_code = [[data objectForKey:@"error_code"] intValue];
	if(error_code==0){
    	NSDictionary *userinfo= [data  objectForKey:@"user"];
		self.user.user_id = [userinfo  objectForKey:@"id"];
		self.user.nickname = [userinfo  objectForKey:@"nickname"];
		self.user.twitter_id = [userinfo objectForKey:@"twitter_id"];
		self.user.facebook_id = [userinfo objectForKey:@"facebook_id"];
		self.user.drinking = (bool)[userinfo objectForKey:@"drinking"];
		self.user.logged = YES;
	    [self gotoDashboard];
>>>>>>> fc2bdcda14e3bc0d1ab40fee0ed3cee1a60dc6a7
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginError" object:self];
        self.user.logged = NO;
    }
}

- (IBAction) gotoSignUp:(id)sender {
	SignUp *_signUpView = [[SignUp alloc] initWithNibName:@"SignUp" bundle:nil];
	BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
	self.signUpView = _signUpView;
	[_signUpView release];
	[beerCounterDelegate.navController pushViewController:_signUpView animated:true];
}

- (void) gotoDashboard {
	BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
    beerCounterDelegate.user = self.user;
    if(beerCounterDelegate.user.drinking) {
        Counter *counter = [[Counter alloc] init];
        NSMutableArray *viewControllers = (NSMutableArray *)beerCounterDelegate.tabBar.viewControllers;
        [viewControllers replaceObjectAtIndex:1 withObject:counter];
        [beerCounterDelegate.tabBar setViewControllers:viewControllers];
        [counter release];
    }
    self.tabBar = beerCounterDelegate.tabBar;
    [beerCounterDelegate.navController setNavigationBarHidden:true];
	[beerCounterDelegate.navController pushViewController:tabBar animated:true];
}

- (void) loginError {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginError" object:self];
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
