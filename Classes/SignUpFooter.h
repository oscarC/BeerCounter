//
//  SignUpFooterViewController.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/9/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class O2Authentication;

@interface SignUpFooter : UIViewController {
	O2Authentication *auth;
    UITabBarController *tabBar;
}

@property (nonatomic, retain) O2Authentication *auth;
@property (nonatomic, retain) UITabBarController *tabBar;

- (IBAction) registerUser:(id)sender;

@end
