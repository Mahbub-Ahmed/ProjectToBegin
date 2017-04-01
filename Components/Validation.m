//
//  Validation.m
//  ProjectToBegin
//
//  Created by Mahbub Ahmed on 2/12/17.
//  Copyright © 2017 Mahbub Ahmed. All rights reserved.
//

#import "Validation.h"

@implementation Validation


//Email validation
-(BOOL)validateEmail:(MATextField *)emailField{
    
    //Email field empty
    if([emailField.text length]==0){
        [emailField setErrorMessage:@"Email is required"];
        return false;
    }
    
    //Using regular expression matcher with predicate
    //Regular expression to match email address must contain some char one '@' some more char one dot(.) and 2 to 4 more char for domain end 
    NSString *emailRegex = @"[A-Z0-9a-z._%+]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    //Invalid email address
    if(![emailTest evaluateWithObject:emailField.text]){
        [emailField setErrorMessage:@"Invalid Email address"];
        return false;
    }
    return true;
}


//pasword validation
-(BOOL)validatePassword:(MATextField *)passField{
    
    //Passworld field empty
    if([passField.text length]==0){
        [passField setErrorMessage:@"Password is required"];
        return false;
    }
    //password is less or grater then  Max & Min password Length
    else if([passField.text length]<4 || [passField.text length]>10){
        [passField setErrorMessage:@"Must contain 4 to 10 Char"];
        return false;
    }
    
    //1 number ,1 capital char ,min 4 ,max 10 character
    NSString *passRegex  = @"^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{4,10}$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passRegex];
    
    //Invalid password
    if(![passwordTest evaluateWithObject:passField.text]){
        [passField setErrorMessage:@"Must contain Capital Latter & Number"];
        return false;
    }
    return true;
}


@end
