//
//  EditContactViewController.h
//  ProjectToBegin
//
//  Created by Mahbub Ahmed on 2/20/17.
//  Copyright © 2017 Mahbub Ahmed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAContactManager.h"

@interface MAEditContactViewController : UIViewController

//first name text field
@property (strong, nonatomic) IBOutlet UITextField *firstNameField;

//last name text field
@property (strong, nonatomic) IBOutlet UITextField *lastNameField;

//phone number text field
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberField;



//email text field
@property (strong, nonatomic) IBOutlet UITextField *emailField;

//button to change image
@property (strong, nonatomic) IBOutlet UIButton *changeImageButton;

//'Contact' object to recive the selected contact form detail view
@property (nonatomic, strong) Contacts *contact;
@end
