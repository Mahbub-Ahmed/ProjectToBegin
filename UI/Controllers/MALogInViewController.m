//
//  ViewController.m
//  ProjectToBegin
//
//  Created by Mahbub Ahmed on 2/12/17.
//  Copyright © 2017 Mahbub Ahmed. All rights reserved.
//

#import "MALogInViewController.h"
#import "MAConstants.h"

@interface MALogInViewController ()

@end

@implementation MALogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setView];
}

//Setting view
-(void)setView{
    
    //Setting email field Icon and place holder
    [_emailField setTextFieldIcon:@"envelope.png"];
    [_emailField setPlaceHolderLabel:@"Email Address"];
    
    
    //Setting password field Icon and place holder
    [_passField setPlaceHolderLabel:@"Password"];
    [_passField setTextFieldIcon:@"padlock.png"];
    
    //enable password field secure text entry
    _passField.secureTextEntry=true;
    
}

//In viewWillAppear setting main background as navigatin bar backgorund
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationItem setHidesBackButton:YES];
}

//In viewWillDisappear resetting the main navigation bar to default
-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    [self.navigationItem setHidesBackButton:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


//Sign in button action
- (IBAction)signInButton:(id)sender {
    
    // by default set the validation true
    BOOL valid = true;
    
    //Init validating for validating email and password fields
    Validation *validate=[[Validation alloc]init];
    
    //if invalid email the validator will set the error message
    //so just set the valid flag false
    if(![validate validateEmail:_emailField]){
        valid=false;
    }
    if(![validate validatePassword:_passField]){
        valid=false;
    }
    
    // If the flag is still valid proceed to login
    if(valid){
        
        Auth *auth=[[Auth alloc]init];
        
        //Callback function is passed in thired parameter that will be call after login process
        [auth loginWithEmail:_emailField.inputText password:_passField.inputText completion:^(NSInteger loginStatus){
            
            //Login success, Navigate  user to  home page
            if(loginStatus==LOGIN_SUCCESS){
                UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HOME_VIEW"];
                [self.navigationController pushViewController:newViewController animated:YES];
            }
            //Login fail, show error massage & keep user in login page
            else if(loginStatus==LOGIN_FAILED){
                [_passField setErrorMessage:@"Invalid Username or Password"];
            }
            //server error, show error massage & keep user in login page
            else{
                [_passField setErrorMessage:@"Server error, please try again."];
            }
        }];
    }
}


@end
