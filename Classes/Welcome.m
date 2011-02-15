//
//  WelcomeTableViewController.m
//  BeerCounter
//
//  Created by Oscar De Moya on 2/8/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "Welcome.h"

#define kLoginUsernameTag  1
#define kLoginPasswordTag  2
#define kIndicatorLoginTag 3

@implementation Welcome

@synthesize welcomeFooter;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Login";
    self.tableView.allowsSelection = NO;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLoadingIndicator) name:@"LoginStart" object:welcomeFooter];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideLoadingIndicator) name:@"LoginEnd" object:welcomeFooter];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAlert) name:@"LoginError" object:welcomeFooter];
}

- (void) showAlert {
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You have entered a wrong email or password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

- (void) showLoadingIndicator {
	UIActivityIndicatorView  *av = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
	av.frame = CGRectMake(145, 160, 25, 25);
	av.tag   = kIndicatorLoginTag;
	[self.view addSubview:av];		
	[av startAnimating];
}

- (void) hideLoadingIndicator {
	UIActivityIndicatorView *av = (UIActivityIndicatorView *)[self.view viewWithTag:kIndicatorLoginTag];
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
					[self setStyles:textField withTag:kLoginUsernameTag];
					textField.placeholder = [NSString stringWithFormat:@"example@gmail.com"];
					textField.keyboardType = UIKeyboardTypeEmailAddress;
					textField.returnKeyType = UIReturnKeyNext;
					[textField addTarget:self
										action:@selector(dismissKeyboard:)
										forControlEvents:UIControlEventEditingDidEndOnExit];
					[textField addTarget:self
										  action:@selector(passValues:)
								forControlEvents:UIControlEventEditingChanged];
					[cell addSubview:textField];

				} else { // Password row
					[self setStyles:textField withTag:kLoginPasswordTag];
					textField.placeholder = [NSString stringWithFormat:@"Required"];
					textField.keyboardType = UIKeyboardTypeDefault;
					textField.returnKeyType = UIReturnKeyDone;
					textField.secureTextEntry = YES;
					[textField addTarget:self
										  action:@selector(dismissKeyboard:)
										  forControlEvents:UIControlEventEditingDidEndOnExit];
					[textField addTarget:self
										  action:@selector(passValues:)
										  forControlEvents:UIControlEventEditingChanged];
					[cell addSubview:textField];
				}
                [textField release];
			}
		}
	}
	if ([indexPath section] == 0) { // Email & Password Section
		if ([indexPath row] == 0) { // Email
			cell.textLabel.text = @"Email";
		} else {
			cell.textLabel.text = @"Password";
		}
	}
	return cell;    
}

- (void)setStyles:(UITextField *)textField withTag:(int)tag {
	textField.adjustsFontSizeToFitWidth = YES;
	textField.textColor = [UIColor blackColor];
	textField.backgroundColor = [UIColor whiteColor];
	textField.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
	textField.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
	textField.textAlignment = UITextAlignmentLeft;
	textField.tag = tag;
	textField.clearButtonMode = UITextFieldViewModeNever; // no clear 'x' button to the right
	textField.enabled = YES;
	//textField.delegate = self;
}

- (void)passValues:(UITextField *)textField {
	if (textField.tag == kLoginUsernameTag) {
		welcomeFooter.username = [textField.text copy];
	} else if (textField.tag == kLoginPasswordTag) {
		welcomeFooter.password = [textField.text copy];
	}
}

- (void)dismissKeyboard:(id)sender {
	[sender resignFirstResponder];
}

/*
- (void)textFieldDidEndEditing:(UITextField *)textField {
	//do stuff
}
*/

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
			return 148.0;
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

