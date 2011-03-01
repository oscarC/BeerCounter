//
//  StartDrinking.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/21/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class O2Request;

@interface StartDrinking : UITableViewController {
    O2Request *request;
}

- (void) startDrinking;
- (void) startDrinkingResponse;

@end
