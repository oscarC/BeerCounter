//
//  O2TableViewHelper.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/15/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define TAG_TF_LOGIN_USERNAME       1
#define TAG_TF_LOGIN_PASSWORD       2
#define TAG_INDICATOR_LOGIN         3

#define TAG_TF_CONNECT_EMAIL        4
#define TAG_TF_CONNECT_USERNAME     5

#define TAG_TF_SIGN_UP_EMAIL        6
#define TAG_TF_SIGN_UP_PASSWORD     7
#define TAG_TF_SIGN_UP_USERNAME     8

#define TAG_SWITCH_TWITTER_CONNECT  9
#define TAG_SWITCH_FACEBOOK_CONNECT 10

@interface O2FormHelper : NSObject {
}

+ (void)setStyles:(UITextField *)textField withTag:(int)tag;
+ (void)dismissKeyboard:(id)sender;

@end
