//
//  FriendsList.m
//  BeerCounter
//
//  Created by Oscar De Moya on 2/14/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "FriendsList.h"
#import "BeerCounterAppDelegate.h"
#import "DrinkList.h"
#import "O2Request.h"
#define CONST_textLabelFontSize     18
#define CONST_detailLabelFontSize   13

@implementation FriendsList

@synthesize usersArray;

static UIFont *subFont;
static UIFont *titleFont;





- (UIFont*) TitleFont {
	if (!titleFont) titleFont = [UIFont boldSystemFontOfSize:CONST_textLabelFontSize];
	return titleFont;
}

- (UIFont*) SubFont {
	if (!subFont) subFont = [UIFont systemFontOfSize:CONST_detailLabelFontSize];
	return subFont;
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


- (void) userList {
	NSMutableDictionary *data = [NSMutableDictionary dictionary];
	BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
	[data setObject:beerCounterDelegate.user.user_id forKey:@"user_id"];
	[request get:@"Friends/feeds" withData:data];
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(userListResponse)name:@"O2RequestFinished" object:request];
}

- (void) userListResponse {
	self.usersArray = [[request data] copy];
	[self.tableView reloadData];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userListResponse) name:@"O2RequestFinished" object:request];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
     self.navigationItem.title=@"Friends - Feeds";
    request = [O2Request request];
    [self userList];
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
    return [self.usersArray count];;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellDrinks";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	NSDictionary *info = [usersArray objectAtIndex:indexPath.row];
    // Configure the cell.
    
    UIImage *cellImage = [UIImage imageNamed:@"user.png"];
	cell.imageView.image = cellImage;
    cell.textLabel.numberOfLines = 0;
	cell.textLabel.font = [self TitleFont];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [info objectForKey:@"username"]];
    NSString *count=[NSString stringWithFormat:@"%@", [info objectForKey:@"count"]];
    NSString *drink_name = [NSString stringWithFormat:@" %@", [info objectForKey:@"drink_name"]];
    NSString *description = [count stringByAppendingString:drink_name];
    NSString *location =[info objectForKey:@"location"];
	
    cell.detailTextLabel.numberOfLines = 0;
	cell.detailTextLabel.font = [self SubFont];
 	cell.detailTextLabel.text = [NSString stringWithFormat:@"%@\n%@", description, location];
	return cell;
    
  
	
    
}



- (CGFloat)tableView:(UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *)indexPath    {
   return 65;
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
