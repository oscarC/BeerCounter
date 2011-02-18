//
//  Settings.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/18/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class O2Authentication;

@interface Settings : UITableViewController {
    O2Authentication *auth;
}

@property (nonatomic, retain) O2Authentication *auth;

- (void)bcLogout;
- (void)passValues:(UISwitch *)uiSwitch;

@end
