//
//  ViewController.h
//  ProjectToBegin
//
//  Created by Mahbub Ahmed on 2/12/17.
//  Copyright © 2017 Mahbub Ahmed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Validation.h"
#import "Auth.h"
#import "MATextField.h"
#import <SVProgressHUD.h>

@interface MALogInViewController : UIViewController

//Email text field
@property (strong, nonatomic) IBOutlet MATextField *emailField;

//Password text field
@property (strong, nonatomic) IBOutlet MATextField *passField;

@end

