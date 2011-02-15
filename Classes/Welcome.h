//
//  WelcomeTableViewController.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/8/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WelcomeFooter.h"

@interface Welcome : UITableViewController {
    WelcomeFooter *welcomeFooter;
}

@property (nonatomic, retain) WelcomeFooter *welcomeFooter;

- (void) showAlert;
- (void) showLoadingIndicator;
- (void) hideLoadingIndicator;
- (void) setStyles:(UITextField *)textField withTag:(int)tag;
- (void) passValues:(UITextField *)textField;
- (void) dismissKeyboard:(id)sender;

@end
