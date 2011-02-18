//
//  Counter.m
//  BeerCounter
//
//  Created by Oscar De Moya on 2/14/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "Counter.h"
#import "BeerCounterAppDelegate.h"
#import "O2Request.h"

@implementation Counter

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"My Drinks";
    request = [O2Request request];
}

- (IBAction) stopDrinking:(id)sender {
    BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSMutableDictionary *data = [NSMutableDictionary dictionary];
	[data setObject:beerCounterDelegate.auth.user.user_id forKey:@"user_id"];
    [data setObject:@"false" forKey:@"drinking"];
	[request post:@"User/drinking" withData:data];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopDrinkingResponse) name:@"O2RequestFinished" object:request];
}

- (void) stopDrinkingResponse {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"O2RequestFinished" object:request];
	NSDictionary *data = [request data];
	NSLog(@"%@", data);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [request release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
