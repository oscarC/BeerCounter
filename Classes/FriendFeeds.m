//
//  FriendsFeed.m
//  BeerCounter
//
//  Created by Oscar De Moya on 2/14/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "FriendFeeds.h"
#import "BeerCounterAppDelegate.h"
#import "DrinkList.h"
#import "O2Request.h"
#import "O2Navigation.h"

@implementation FriendFeeds

@synthesize request, arrayFeeds;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Feeds";
    request = [O2Request request];
    
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editFriends)];
}

- (void) friendFeeds {
	NSMutableDictionary *data = [NSMutableDictionary dictionary];
	BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
	[data setObject:beerCounterDelegate.auth.user.user_id forKey:@"user_id"];
	[request get:@"Friends/feeds" withData:data];
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(friendFeedsResponse)name:@"O2RequestFinished" object:request];
}

- (void) friendFeedsResponse {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"O2RequestFinished" object:request];
    
	self.arrayFeeds = [[request data] copy];
    NSLog(@"%@", [request data]);
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self friendFeeds];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    return [self.arrayFeeds count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellDrinks";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	NSDictionary *info = [arrayFeeds objectAtIndex:indexPath.row];
    
    UIImage *cellImage = [UIImage imageNamed:@"user.png"];
	cell.imageView.image = cellImage;
    cell.textLabel.numberOfLines = 0;
	cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [info objectForKey:@"username"]];
    NSString *count=[NSString stringWithFormat:@"%@", [info objectForKey:@"count"]];
    NSString *drink_name = [NSString stringWithFormat:@" %@", [info objectForKey:@"drink_name"]];
    NSString *description = [count stringByAppendingString:drink_name];
    NSString *location =[info objectForKey:@"location"];
	
    cell.detailTextLabel.numberOfLines = 0;
	cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
 	cell.detailTextLabel.text = [NSString stringWithFormat:@"%@\n%@", description, location];
	return cell;
}

- (CGFloat)tableView:(UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *)indexPath    {
   return 65;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
