//
//  SignUpTableViewController.m
//  BeerCounter
//
//  Created by Oscar De Moya on 2/9/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "SignUp.h"
#import "SignUpFooter.h"

#define kSignUpEmailTag	   1
#define kSignUpPasswordTag 2
#define kSignUpNicknameTag 3

@implementation SignUp


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Sign Up";
	self.tableView.allowsSelection = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLoadingIndicator) name:@"LoginEnd" object:signUpFooter];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
			
			if ([indexPath section] == 0) { // Email & Password Section
				if ([indexPath row] == 0) { // Username row
					emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
					[self setStyles:emailTextField withTag:kSignUpEmailTag];
					emailTextField.placeholder = [NSString stringWithFormat:@"example@gmail.com"];
					emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
					emailTextField.returnKeyType = UIReturnKeyNext;
					[emailTextField addTarget:self
										  action:@selector(dismissKeyboard:)
								forControlEvents:UIControlEventEditingDidEndOnExit];
					[emailTextField addTarget:self
										  action:@selector(passValues:)
								forControlEvents:UIControlEventEditingChanged];
					[cell addSubview:emailTextField];
					[emailTextField release];
				} else if ([indexPath row] == 1) { // Password row
					passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
					[self setStyles:passwordTextField withTag:kSignUpPasswordTag];
					passwordTextField.placeholder = [NSString stringWithFormat:@"Required"];
					passwordTextField.keyboardType = UIKeyboardTypeDefault;
					passwordTextField.returnKeyType = UIReturnKeyNext;
					passwordTextField.secureTextEntry = YES;
					[passwordTextField addTarget:self
										  action:@selector(dismissKeyboard:)
								forControlEvents:UIControlEventEditingDidEndOnExit];
					[passwordTextField addTarget:self
										  action:@selector(passValues:)
								forControlEvents:UIControlEventEditingChanged];
					[cell addSubview:passwordTextField];
					[passwordTextField release];
				} else if ([indexPath row] == 2) { // Password row
					nicknameTextField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
					[self setStyles:nicknameTextField withTag:kSignUpNicknameTag];
					nicknameTextField.placeholder = [NSString stringWithFormat:@"Required"];
					nicknameTextField.keyboardType = UIKeyboardTypeDefault;
					nicknameTextField.returnKeyType = UIReturnKeyDone;
					[nicknameTextField addTarget:self
										  action:@selector(dismissKeyboard:)
								forControlEvents:UIControlEventEditingDidEndOnExit];
					[nicknameTextField addTarget:self
										  action:@selector(passValues:)
								forControlEvents:UIControlEventEditingChanged];
					[cell addSubview:nicknameTextField];
					[nicknameTextField release];
				}
			}
		}
	}
	if ([indexPath section] == 0) { // Sign Up Section
		if ([indexPath row] == 0) { // Email
			cell.textLabel.text = @"Email";
		} else if ([indexPath row] == 1) { // Password
			cell.textLabel.text = @"Password";
		} else if ([indexPath row] == 2) { // Nickname
			cell.textLabel.text = @"Nickname";
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
	if (textField.tag == kSignUpEmailTag) {
		signUpFooter.email = [textField.text copy];
	} else if (textField.tag == kSignUpPasswordTag) {
		signUpFooter.password = [textField.text copy];
	} else if (textField.tag == kSignUpNicknameTag) {
		signUpFooter.nickname = [textField.text copy];
	}
}

- (void)dismissKeyboard:(id)sender {
	[sender resignFirstResponder];
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
