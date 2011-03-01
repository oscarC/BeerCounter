//
//  PlaceList.m
//  BeerCounter
//
//  Created by Oscar De Moya on 2/21/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "PlaceList.h"
#import "BeerCounterAppDelegate.h"
#import "O2Navigation.h"
#import "O2Request.h"
#import "User.h"

@implementation PlaceList

@synthesize dataArray;

- (void) placeList {
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
	[data setObject:@"11.00726807" forKey:@"geolat"];
    [data setObject:@"-74.81023848" forKey:@"geolong"];
    [data setObject:@"10" forKey:@"l"];
	[request _get:@"https://api.foursquare.com/v1/venues.json" withData:data];
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(placeListResponse)name:@"O2RequestFinished" object:request];
}

- (void) placeListResponse {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"O2RequestFinished" object:request];
    
    NSDictionary *data = [request data];
    NSArray *groups = [data objectForKey:@"groups"];
    NSDictionary *nearby = [groups objectAtIndex:0];
    self.dataArray = [nearby objectForKey:@"venues"];
	[self.tableView reloadData];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [dataArray release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    request = [O2Request request];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self placeList];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataArray count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellPlaces";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	NSDictionary *info = [dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [info objectForKey:@"name"]];
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [info objectForKey:@"address"]];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
    O2Navigation *nav = beerCounterDelegate.auth.navigation;
    NSDictionary *info = [dataArray objectAtIndex:indexPath.row];
    [beerCounterDelegate.auth.user setPlace:info];
    [nav backStartDrinking];
}

@end
