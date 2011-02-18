//
//  SocialSignUp.m
//  BeerCounter
//
//  Created by Oscar De Moya on 2/15/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "SocialSignUp.h"
#import "BeerCounterAppDelegate.h"
#import "AppGlobal.h"
#import "O2FormHelper.h"
#import "SignUpFooter.h"

@implementation SocialSignUp

@synthesize signUpFooter;

- (void) showAlert:(NSNotification *)note {
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[[note userInfo] valueForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"Sign Up";
	self.tableView.allowsSelection = NO;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if(gSignUpMode == FACEBOOK_CONNECT) {
        return 1;
    } else if(gSignUpMode == TWITTER_CONNECT) {
        return 2;
    }
    return 0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"CellConnect";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryNone;
		
		if ([indexPath section] == 0) {
			if ([indexPath section] == 0) {
                UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
                if(gSignUpMode == FACEBOOK_CONNECT) {
                    [O2FormHelper setStyles:textField withTag:TAG_TF_CONNECT_USERNAME];
                    textField.placeholder = [NSString stringWithFormat:@"Required"];
                    textField.keyboardType = UIKeyboardTypeDefault;
                } else if(gSignUpMode == TWITTER_CONNECT) {
                    if ([indexPath row] == 0) { // Email row
                        [O2FormHelper setStyles:textField withTag:TAG_TF_CONNECT_EMAIL];
                        textField.placeholder = [NSString stringWithFormat:@"example@gmail.com"];
                        textField.keyboardType = UIKeyboardTypeEmailAddress;
                    } else {
                        [O2FormHelper setStyles:textField withTag:TAG_TF_CONNECT_USERNAME];
                        textField.placeholder = [NSString stringWithFormat:@"Required"];
                        textField.keyboardType = UIKeyboardTypeDefault;
                    }
                }
                [textField addTarget:self action:@selector(passValues:) forControlEvents:UIControlEventEditingChanged];
                [cell addSubview:textField];
                [textField release];
			}
		}
	}
	if ([indexPath section] == 0) {
        if(gSignUpMode == FACEBOOK_CONNECT) {
            cell.textLabel.text = @"Username";
        } else if(gSignUpMode == TWITTER_CONNECT) {
            if ([indexPath row] == 0) { // Email
                cell.textLabel.text = @"Email";
            } else if ([indexPath row] == 1) { // Username
                cell.textLabel.text = @"Username";
            }
        }
	}
	return cell;
}

- (void)passValues:(UITextField *)textField {
    BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
	User *user = beerCounterDelegate.auth.user;
	if (textField.tag == TAG_TF_CONNECT_EMAIL) {
		user.email = [textField.text copy];
	} else if (textField.tag == TAG_TF_CONNECT_USERNAME) {
		user.username = [textField.text copy];
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection: (NSInteger)section {
	if (section == 0) {
		signUpFooter = [[SignUpFooter alloc] init];
		return signUpFooter.view;
	} else {
		return nil;
	}
}

// Need to call to pad the footer height otherwise the footer collapses
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	switch (section) {
		case 0:
			return 56.0;
		default:
			return 0.0;
	}
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

- (void)dealloc {
    [super dealloc];
}

@end
