//
//  Counter.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/14/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class O2Request;

@interface Counter : UIViewController {
    O2Request *request;
}

- (IBAction) stopDrinking:(id)sender;
- (void) stopDrinkingResponse;

@end
