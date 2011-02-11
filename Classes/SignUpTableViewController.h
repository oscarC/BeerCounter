//
//  SignUpTableViewController.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/9/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SignUpFooterViewController;

@interface SignUpTableViewController : UITableViewController {
	UITextField *emailTextField;
	UITextField *passwordTextField;
	UITextField *nicknameTextField;
	SignUpFooterViewController *signUpFooter;
}

- (void)setStyles:(UITextField *)textField withTag:(int)tag;
- (void)passValues:(UITextField *)textField;
- (void)dismissKeyboard:(id)sender;

@end