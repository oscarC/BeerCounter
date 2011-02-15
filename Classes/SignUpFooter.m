//
//  SignUpFooterViewController.m
//  BeerCounter
//
//  Created by Oscar De Moya on 2/9/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "SignUpFooter.h"
#import "O2Request.h"
#import "BeerCounterAppDelegate.h"
#import "User.h"

@implementation SignUpFooter

@synthesize email, password, nickname,tabBar,user;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	request = [O2Request request];
	email = @"";
	password = @"";
	nickname = @"";
}

- (IBAction) registerUser:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RegistrationStart" object:self];
	NSMutableDictionary *data = [NSMutableDictionary dictionary];
	[data setObject:self.email forKey:@"email"];
	[data setObject:self.password forKey:@"password"];
	[data setObject:self.nickname forKey:@"nickname"];
	[request post:@"User/signup" withData:data];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registerUserResponse) name:@"O2RequestFinished" object:request];
}

- (void) registerUserResponse {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"O2RequestFinished" object:request];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RegistrationEnd" object:self];
	NSDictionary *data = [request data];
    int error_code = [[data objectForKey:@"error_code"] intValue];
    if(error_code==0){
        BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
        self.tabBar = beerCounterDelegate.tabBar;
        [beerCounterDelegate.navController setNavigationBarHidden:TRUE];
        [beerCounterDelegate.navController pushViewController:tabBar animated:true];   
        NSDictionary *userinfo= [data  objectForKey:@"user"];  
        self.user.nickname = [userinfo  objectForKey:@"nickname"];
        self.user.twitter_id = [userinfo objectForKey:@"twitter_id"];
        self.user.facebook_id = [userinfo objectForKey:@"facebook_id"];
        self.user.drinking = (bool)[userinfo objectForKey:@"drinking"];
    }
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
	[request release];
    [super dealloc];
}


@end
