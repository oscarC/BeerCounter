//
//  SignUpFooterViewController.m
//  BeerCounter
//
//  Created by Oscar De Moya on 2/9/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "SignUpFooter.h"
#import "BeerCounterAppDelegate.h"
#import "AppGlobal.h"
#import "O2Request.h"
#import "O2Navigation.h"

@implementation SignUpFooter

@synthesize auth, tabBar;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.auth = beerCounterDelegate.auth;
}

- (IBAction) registerUser:(id)sender {
    [auth registerUser];
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
    [auth release];
    [super dealloc];
}


@end
