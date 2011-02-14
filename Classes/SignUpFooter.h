//
//  SignUpFooterViewController.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/9/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class O2Request;

@interface SignUpFooter : UIViewController {
	O2Request *request;
}

@property (nonatomic, retain) IBOutlet NSString *email;
@property (nonatomic, retain) IBOutlet NSString *password;
@property (nonatomic, retain) IBOutlet NSString *nickname;

- (IBAction) registerUser:(id)sender;
- (void) registerUserResponse;

@end
