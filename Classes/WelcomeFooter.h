//
//  LoginFooterViewController.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/9/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class O2Authentication;

@interface WelcomeFooter : UIViewController {
    O2Authentication *auth;
}

@property (nonatomic, retain) O2Authentication *auth;

- (IBAction) bcLogin:(id)sender;
- (IBAction) gotoSignUp:(id)sender;
- (IBAction) fbLogin:(id)sender;
- (IBAction) fbLogout:(id)sender;
- (IBAction) twLogout:(id)sender;

@end
