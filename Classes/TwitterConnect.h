//
//  TwitterConnect.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/16/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SA_OAuthTwitterController.h"

@class SA_OAuthTwitterEngine;

@interface TwitterConnect : NSObject<SA_OAuthTwitterControllerDelegate> {
    SA_OAuthTwitterEngine *_engine;
}

+ (TwitterConnect *) twitterConnect;
- (void) initEngine;
- (NSString *) cachedUsername;
- (BOOL) isAuthorized;
- (UIViewController *) controller;
- (void) logout;

@end
