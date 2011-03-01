//
//  FriendList.m
//  BeerCounter
//
//  Created by Oscar De Moya on 2/21/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "FollowingList.h"
#import "BeerCounterAppDelegate.h"
#import "O2Request.h"
#import "O2AlertPrompt.h"
#import "User.h"

@implementation FollowingList

@synthesize dataArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Following";
    
    request = [O2Request request];
	[self friendList];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) showAlert:(NSString *)errorMsg withTitle:(NSString *)title {
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:errorMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

- (void) askUsername {
    O2AlertPrompt *prompt = [O2AlertPrompt alloc];
    prompt = [prompt initWithTitle:@"Follow User" message:@"Enter an username or email" delegate:self cancelButtonTitle:@"Cancel" okButtonTitle:@"Follow"];
    [prompt show];
    [prompt release];
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (buttonIndex != [alertView cancelButtonIndex]) {
		NSString *entered = [(O2AlertPrompt *)alertView enteredText];
		NSLog(@"You typed: %@", entered);
        [self followFriend:entered];
	}
}

- (void) followFriend:(NSString *)username {
    BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject:beerCounterDelegate.auth.user.user_id forKey:@"user_id"];
	[data setObject:username forKey:@"username"];
	[request post:@"User/follow" withData:data];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(followFriendResponse) name:@"O2RequestFinished" object:request];
}

- (void) followFriendResponse {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"O2RequestFinished" object:request];
	NSDictionary *data = [request data];
	NSLog(@"%@", data);
    int error_code = [[data objectForKey:@"error_code"] intValue];
    if([data count]>0 && error_code==0) {
        NSDictionary *following = [data objectForKey:@"following"];
        NSLog(@"%@", following);
        [self showAlert:[NSString stringWithFormat:@"You are now following '%@'.", [following objectForKey:@"username"]] withTitle:@"Success"];
    } else if(error_code == 107) {
        [self showAlert:@"No user with the entered username/email was found." withTitle:@"User not found"];
    }
    [self friendList];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) friendList {
	NSMutableDictionary *data = [NSMutableDictionary dictionary];
	BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
	[data setObject:beerCounterDelegate.auth.user.user_id forKey:@"user_id"];
	[request get:@"Friends/list" withData:data];
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(friendListResponse)name:@"O2RequestFinished" object:request];
}

- (void) friendListResponse {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"O2RequestFinished" object:request];
    
    NSDictionary *data = [request data];
    NSLog(@"%@", [request data]);
    
    int error_code = [[data objectForKey:@"error_code"] intValue];
    if([data count]>0 && error_code==0) {
        self.dataArray = [data objectForKey:@"friends"];
    } else {
        self.dataArray = [[NSArray alloc] init];
    }
	[self.tableView reloadData];
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
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //self.navigationController.toolbar.hidden = NO;
    UIBarButtonItem *button1 = [[UIBarButtonItem alloc] initWithTitle:@"Follow User" style:UIBarButtonItemStyleBordered target:self action:@selector(askUsername)];
    UIBarButtonItem *button2 = [[UIBarButtonItem alloc] initWithTitle:@"Invite People" style:UIBarButtonItemStyleBordered target:self action:@selector(askUsername)];
    button1.width = 148.0;
    button2.width = 148.0;
    NSArray *buttons = [NSArray arrayWithObjects: button1, button2, nil];
    [self.navigationController.toolbar setItems: buttons animated:NO];
    [button1 release];
    [button2 release];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellFriends";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	NSDictionary *info = [dataArray objectAtIndex:indexPath.row];
    
    UIImage *cellImage = [UIImage imageNamed:@"user.png"];
	cell.imageView.image = cellImage;
	cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [info objectForKey:@"username"]];
	
	cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
 	cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [info objectForKey:@"drinking"]];
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
