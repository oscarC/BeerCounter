//
//  HomeViewController.m
//  BeerCounter
//
//  Created by Oscar De Moya on 2/10/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "HomeViewController.h"
#import "BeerCounterAppDelegate.h"
#import "O2Request.h"

@implementation HomeViewController

@synthesize labelStatus;

- (IBAction) startDrinking:(id)sender {
    BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSMutableDictionary *data = [NSMutableDictionary dictionary];
	[data setObject:beerCounterDelegate.user.user_id forKey:@"user_id"];
	[request post:@"User/strart_drink" withData:data];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startDrinkingResponse) name:@"O2RequestFinished" object:request];
}

- (void) startDrinkingResponse {
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
    BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
    if(beerCounterDelegate.user.drinking == NO) {
        labelStatus.text = @"You're not currently drinking.";
    } else {
        
    }
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
