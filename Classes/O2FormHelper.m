//
//  O2TableViewHelper.m
//  BeerCounter
//
//  Created by Oscar De Moya on 2/15/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "O2FormHelper.h"

@implementation O2FormHelper

+ (void)setStyles:(UITextField *)textField withTag:(int)tag {
	textField.adjustsFontSizeToFitWidth = YES;
	textField.textColor = [UIColor blackColor];
	textField.backgroundColor = [UIColor whiteColor];
	textField.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
	textField.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
	textField.textAlignment = UITextAlignmentLeft;
	textField.tag = tag;
	textField.clearButtonMode = UITextFieldViewModeNever; // no clear 'x' button to the right
	textField.enabled = YES;
	//textField.delegate = self;
    [textField addTarget:self action:@selector(dismissKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
}

+ (void)dismissKeyboard:(id)sender {
	[sender resignFirstResponder];
}

@end
