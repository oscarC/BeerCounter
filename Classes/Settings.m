//
//  Settings.m
//  BeerCounter
//
//  Created by Oscar De Moya on 2/18/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "Settings.h"
#import "BeerCounterAppDelegate.h"
#import "O2FormHelper.h"

@implementation Settings

@synthesize auth;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Settings";
    self.tableView.allowsSelection = NO;
    
    UIBarButtonItem *btnLogout = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(bcLogout)];
    self.navigationItem.rightBarButtonItem = btnLogout;
    BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.auth = beerCounterDelegate.auth;
}

- (void)bcLogout
{
    [auth bcLogout];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellSettings";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryNone;
		//cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		if ([indexPath section] == 0) {
            
			if ([indexPath section] == 0) {
                UISwitch *uiSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(208, 9, 185, 30)];
				if ([indexPath row] == 0) { // Twitter Connect
                    if([auth.twitter isAuthorized]) uiSwitch.on = YES;
					uiSwitch.tag = TAG_SWITCH_TWITTER_CONNECT;
				} else { // Facebook Connect
                    if([auth.facebook isSessionValid]) uiSwitch.on = YES;
					uiSwitch.tag = TAG_SWITCH_FACEBOOK_CONNECT;
				}
                [uiSwitch addTarget:self action:@selector(passValues:) forControlEvents:UIControlEventValueChanged];
                [cell addSubview:uiSwitch];
                [uiSwitch release];
			}
		}
	}
	if ([indexPath section] == 0) {
		if ([indexPath row] == 0) {
			cell.textLabel.text = @"Twitter";
		} else {
			cell.textLabel.text = @"Facebook";
		}
	}
	return cell;   
}

- (void)passValues:(UISwitch *)uiSwitch {
	if(uiSwitch.tag == TAG_SWITCH_TWITTER_CONNECT) {
        if(uiSwitch.on) {
            //[auth twLogin];
        } else {
            [auth twLogout];
        }
	} else if(uiSwitch.tag == TAG_SWITCH_FACEBOOK_CONNECT) {
        if(uiSwitch.on) {
            
        } else {
            [auth fbLogout];
        }
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if(section == 0) {
		return @"Social Connections";
	} else {
		return @"";
	}
	
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

- (void)dealloc
{
    [auth release];
    [super dealloc];
}

@end
