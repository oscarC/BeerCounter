//
//  SignUpTableViewController.m
//  BeerCounter
//
//  Created by Oscar De Moya on 2/9/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "SignUp.h"
#import "BeerCounterAppDelegate.h"
#import "SignUpFooter.h"
#import "O2FormHelper.h"

@implementation SignUp

@synthesize signUpFooter;

- (void) showAlert:(NSNotification *)note {
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[[note userInfo] valueForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Sign Up";
	self.tableView.allowsSelection = NO;
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
    return 3;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"CellSignUp";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryNone;
		//cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		if ([indexPath section] == 0) {
			
			if ([indexPath section] == 0) {
                UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
				if ([indexPath row] == 0) { // Email row
					[O2FormHelper setStyles:textField withTag:TAG_TF_SIGN_UP_EMAIL];
					textField.placeholder = [NSString stringWithFormat:@"example@gmail.com"];
					textField.keyboardType = UIKeyboardTypeEmailAddress;
				} else if ([indexPath row] == 1) {  // Password row
					[O2FormHelper setStyles:textField withTag:TAG_TF_SIGN_UP_PASSWORD];
					textField.placeholder = [NSString stringWithFormat:@"Required"];
					textField.keyboardType = UIKeyboardTypeDefault;
					textField.secureTextEntry = YES;
				} else if ([indexPath row] == 2) { // Username row
					[O2FormHelper setStyles:textField withTag:TAG_TF_SIGN_UP_USERNAME];
					textField.placeholder = [NSString stringWithFormat:@"Required"];
					textField.keyboardType = UIKeyboardTypeDefault;
				}
                [textField addTarget:self action:@selector(passValues:) forControlEvents:UIControlEventEditingChanged];
                [cell addSubview:textField];
                [textField release];
			}
		}
	}
	if ([indexPath section] == 0) { // Sign Up Section
		if ([indexPath row] == 0) { // Email
			cell.textLabel.text = @"Email";
		} else if ([indexPath row] == 1) { // Password
			cell.textLabel.text = @"Password";
		} else if ([indexPath row] == 2) { // Username
			cell.textLabel.text = @"Username";
		}
	}
	return cell;
}

- (void)passValues:(UITextField *)textField {
    BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
    User *user = beerCounterDelegate.auth.user;
	if (textField.tag == TAG_TF_SIGN_UP_EMAIL) {
		user.email = [textField.text copy];
	} else if (textField.tag == TAG_TF_SIGN_UP_PASSWORD) {
		user.password = [textField.text copy];
	} else if (textField.tag == TAG_TF_SIGN_UP_USERNAME) {
		user.username = [textField.text copy];
	}
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
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
