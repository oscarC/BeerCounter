//
//  HomeViewController.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/10/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@class O2Request;

@interface Home : UIViewController<FBDialogDelegate> {
    O2Request *request;
    IBOutlet UILabel *labelStatus;
}

@property (nonatomic, retain) UILabel *labelStatus;

- (void) gotoStartDrinking;
- (IBAction) updateStatus:(id)sender;

@end
