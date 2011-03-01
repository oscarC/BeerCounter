//
//  O2AlertPrompt.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/23/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface O2AlertPrompt : UIAlertView {
    UITextField *textField;
}

@property (nonatomic, retain) UITextField *textField;
@property (readonly) NSString *enteredText;

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okButtonTitle;

@end
