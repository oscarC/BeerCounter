//
//  SignUpTableViewController.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/9/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SignUpFooter;

@interface SignUp : UITableViewController {
	SignUpFooter *signUpFooter;
}

@property (nonatomic, retain) SignUpFooter *signUpFooter;

- (void) showAlert:(NSNotification *)note;
- (void) passValues:(UITextField *)textField;

@end
