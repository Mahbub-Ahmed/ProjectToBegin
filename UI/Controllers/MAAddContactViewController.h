//
//  AddContactViewController.h
//  ProjectToBegin
//
//  Created by Mahbub Ahmed on 2/19/17.
//  Copyright © 2017 Mahbub Ahmed. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MAAddContactTextField.h"
#import "MAContactManager.h"

@interface MAAddContactViewController : UIViewController<UITextFieldDelegate>

//add image for new contact
@property (strong, nonatomic) IBOutlet UIButton *addImageButton;

//New contact first name text field
@property (strong, nonatomic) IBOutlet UITextField *firstNameField;

//New contact last name text field
@property (strong, nonatomic) IBOutlet UITextField *lastNameField;

//New contact phone number text field
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberField;


//New contact email text field
@property (strong, nonatomic) IBOutlet UITextField *emailField;

//button to save new contact
@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageYValConstraint;


@end
