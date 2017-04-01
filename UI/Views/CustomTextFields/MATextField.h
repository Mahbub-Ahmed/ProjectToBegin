//
//  MATextField.h
//  ProjectToBegin
//
//  Custom UITextField
//
//  Created by Mahbub Ahmed on 2/12/17.
//  Copyright © 2017 Mahbub Ahmed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Helper.h"
#import "Validation.h"

@interface MATextField : UITextField<UITextFieldDelegate>

//Text field place holder Label
@property (strong ,nonatomic) UILabel *placeHolder;

//Text Field input text
@property (nonatomic, strong) NSString *inputText;

//Label to display error
@property (strong ,nonatomic) UILabel *errorLabel;

//Set text field leftview icon
-(void)setTextFieldIcon:(NSString*) imageName;

//Set placeholder text
-(void)setPlaceHolderLabel:(NSString*) labelText;

//Set error message
-(void)setErrorMessage:(NSString *)message;
@end
