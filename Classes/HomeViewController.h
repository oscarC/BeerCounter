//
//  HomeViewController.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/10/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class O2Request;

@interface HomeViewController : UIViewController {
    O2Request *request;
    IBOutlet UILabel *labelStatus;
}

@property (nonatomic, retain) UILabel *labelStatus;

- (IBAction) startDrinking:(id)sender;
- (void) startDrinkingResponse;

@end
