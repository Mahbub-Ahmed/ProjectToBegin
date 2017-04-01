//
//  Validation.h
//  ProjectToBegin
//
//  Created by Mahbub Ahmed on 2/12/17.
//  Copyright © 2017 Mahbub Ahmed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MATextField.h"
#import <UIKit/UIKit.h>
@class MATextField;


@interface Validation : NSObject

//Email validation
-(BOOL)validateEmail:(MATextField *)emailField;

//Password validation
-(BOOL)validatePassword:(MATextField *)passField;

@end
