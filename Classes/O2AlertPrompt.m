//
//  O2AlertPrompt.m
//  BeerCounter
//
//  Created by Oscar De Moya on 2/23/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "O2AlertPrompt.h"

@implementation O2AlertPrompt

@synthesize textField;
@synthesize enteredText;

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okayButtonTitle
{    
    if ((self = [super initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:okayButtonTitle, nil]))
    {
        UITextField *theTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)]; 
        theTextField.backgroundColor = [UIColor whiteColor];
        theTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        [self addSubview:theTextField];
        self.textField = theTextField;
        [theTextField release];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 4.0) {
            CGAffineTransform translate = CGAffineTransformMakeTranslation(0.0, 130.0); 
            [self setTransform:translate];
        }
    }
    return self;
}

- (void)show
{
    [textField becomeFirstResponder];
    [super show];
}

- (NSString *)enteredText
{
    return textField.text;
}

- (void)dealloc
{
    [textField release];
    [super dealloc];
}

@end
