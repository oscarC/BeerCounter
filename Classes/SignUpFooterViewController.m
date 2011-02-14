//
//  SignUpFooterViewController.m
//  BeerCounter
//
//  Created by Oscar De Moya on 2/9/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "SignUpFooterViewController.h"
#import "O2Request.h"

@implementation SignUpFooterViewController

@synthesize email, password, nickname;

- (IBAction) registerUser:(id)sender {
	NSMutableDictionary *data = [NSMutableDictionary dictionary];
	[data setObject:self.email forKey:@"email"];
	[data setObject:self.password forKey:@"password"];
	[data setObject:self.nickname forKey:@"nickname"];
	[request post:@"User/signup" withData:data];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registerUserResponse) name:@"O2RequestFinished" object:request];
}

- (void) registerUserResponse {
	NSDictionary *data = [request data];
	NSLog(@"%@", data);
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
	email = @"";
	password = @"";
	nickname = @"";
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
