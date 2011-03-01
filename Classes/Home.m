//
//  HomeViewController.m
//  BeerCounter
//
//  Created by Oscar De Moya on 2/10/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "Home.h"
#import "BeerCounterAppDelegate.h"
#import "O2Request.h"
#import "O2Navigation.h"

@implementation Home

@synthesize labelStatus;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"My Drinks";
    request = [O2Request request];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Start" style:UIBarButtonItemStylePlain target:self action:@selector(gotoStartDrinking)];
}

- (void) gotoStartDrinking {
    BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
    O2Navigation *nav = beerCounterDelegate.auth.navigation;
    [nav gotoStartDrinking];
}

- (IBAction) updateStatus:(id)sender {
    BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
    Facebook *facebook = beerCounterDelegate.auth.facebook;
    SBJSON *jsonWriter = [[SBJSON new] autorelease];
    
    NSDictionary* actionLinks = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:
                                                           @"Always Running",@"text",@"http://itsti.me/",@"href", nil], nil];
    
    NSString *actionLinksStr = [jsonWriter stringWithObject:actionLinks];
    NSDictionary* attachment = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"a long run", @"name",
                                @"The Facebook Running app", @"caption",
                                @"it is fun", @"description",
                                @"http://itsti.me/", @"href", nil];
    NSString *attachmentStr = [jsonWriter stringWithObject:attachment];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Share on Facebook",  @"user_message_prompt",
                                   actionLinksStr, @"action_links",
                                   attachmentStr, @"attachment",
                                   nil];
    
    
    [facebook dialog:@"feed"
            andParams:params
          andDelegate:self];
}

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
