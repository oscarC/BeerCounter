//
//  WelcomeTableViewController.m
//  BeerCounter
//
//  Created by Oscar De Moya on 2/8/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "Welcome.h"
#import "BeerCounterAppDelegate.h"
#import "WelcomeFooter.h"
#import "O2FormHelper.h"

@implementation Welcome

@synthesize welcomeFooter;

#define IMG_WELCOME_BACKGROUND @"bc_background"

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Beer Counter";
    self.tableView.allowsSelection = NO;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLoadingIndicator) name:@"LoginStart" object:welcomeFooter];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideLoadingIndicator) name:@"LoginEnd" object:welcomeFooter];
    
    //create new uiview with a background image
    UIImage *backgroundImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:IMG_WELCOME_BACKGROUND ofType:@"png"]];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
    self.tableView.backgroundView = backgroundView;
}

- (void) showLoadingIndicator {
	UIActivityIndicatorView  *av = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
	av.frame = CGRectMake(145, 160, 25, 25);
	av.tag   = TAG_INDICATOR_LOGIN;
	[self.view addSubview:av];		
	[av startAnimating];
}

- (void) hideLoadingIndicator {
	UIActivityIndicatorView *av = (UIActivityIndicatorView *)[self.view viewWithTag:TAG_INDICATOR_LOGIN];
	[av stopAnimating];
	[av removeFromSuperview];
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 2;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"CellWelcome";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryNone;
		//cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		if ([indexPath section] == 0) {

			if ([indexPath section] == 0) { // Email & Password Section
                UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
				if ([indexPath row] == 0) { // Username row
					[O2FormHelper setStyles:textField withTag:TAG_TF_LOGIN_USERNAME];
					textField.placeholder = [NSString stringWithFormat:@"example@gmail.com"];
					textField.keyboardType = UIKeyboardTypeEmailAddress;
				} else { // Password row
					[O2FormHelper setStyles:textField withTag:TAG_TF_LOGIN_PASSWORD];
					textField.placeholder = [NSString stringWithFormat:@"Required"];
					textField.keyboardType = UIKeyboardTypeDefault;
					textField.secureTextEntry = YES;
				}
                [textField addTarget:self action:@selector(passValues:) forControlEvents:UIControlEventEditingChanged];
                [cell addSubview:textField];
                [textField release];
			}
		}
	}
	if ([indexPath section] == 0) {
		if ([indexPath row] == 0) { // Email
			cell.textLabel.text = @"Email";
		} else {
			cell.textLabel.text = @"Password";
		}
	}
	return cell;    
}

- (void)passValues:(UITextField *)textField {
    BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
    User *user = beerCounterDelegate.auth.user;
	if (textField.tag == TAG_TF_LOGIN_USERNAME) {
		user.username = [textField.text copy];
	} else if (textField.tag == TAG_TF_LOGIN_PASSWORD) {
		user.password = [textField.text copy];
	}
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	// create the parent view that will hold header Label
	UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 44.0)];
	
	// create the button object
	UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	headerLabel.backgroundColor = [UIColor clearColor];
	headerLabel.opaque = NO;
	headerLabel.textColor = [UIColor whiteColor];
	headerLabel.highlightedTextColor = [UIColor blackColor];
	headerLabel.font = [UIFont boldSystemFontOfSize:20];
	headerLabel.frame = CGRectMake(10.0, 0.0, 300.0, 44.0);
    
	// If you want to align the header text as centered
	// headerLabel.frame = CGRectMake(150.0, 0.0, 300.0, 44.0);
    
	headerLabel.text = @"Login";
	[customView addSubview:headerLabel];
    
	return customView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 44.0;
}

/*
- (void)textFieldDidEndEditing:(UITextField *)textField {
	//do stuff
}
*/

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection: (NSInteger)section {
	if (section == 0) {
		welcomeFooter = [[WelcomeFooter alloc] init];
		return welcomeFooter.view;
	} else {
		return nil;
	}
}

// Need to call to pad the footer height otherwise the footer collapses
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	switch (section) {
		case 0:
			return 280.0;
		default:
			return 0.0;
	}
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}


@end

