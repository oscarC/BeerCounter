//
//  LoginFooterViewController.m
//  BeerCounter
//
//  Created by Oscar De Moya on 2/9/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "LoginFooterViewController.h"
#import "SignUpTableViewController.h"
#import "HomeViewController.h"
#import "BeerCounterAppDelegate.h"
#import "O2Request.h"

@implementation LoginFooterViewController

@synthesize username, password;
@synthesize signUpView, homeView;

- (IBAction) login:(id)sender {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"LoginStart" object:self];
	NSMutableDictionary *data = [NSMutableDictionary dictionary];
	[data setObject:self.username forKey:@"email"];
	[data setObject:self.password forKey:@"password"];
	[request post:@"Authenticate" withData:data];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginResponse) name:@"O2RequestFinished" object:request];
}

- (void) loginResponse {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"LoginEnd" object:self];
	NSDictionary *data = [request data];
	NSLog(@"%@", data);
	[self gotoDashboard];
}

- (IBAction) gotoSignUp:(id)sender {
	SignUpTableViewController *_signUpView = [[SignUpTableViewController alloc] initWithNibName:@"SignUpTableViewController" bundle:nil];
	BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
	self.signUpView = _signUpView;
	[_signUpView release];
	[beerCounterDelegate.navController pushViewController:_signUpView animated:YES];
}

- (void) gotoDashboard {
	BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
	UITabBarController *tabBar = [beerCounterDelegate tabBar]; 
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
	[request release];
	[super dealloc];
}


@end
