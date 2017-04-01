//
//  MAConstants.m
//  ProjectToBegin
//
//  Created by Mahbub Ahmed on 3/27/17.
//  Copyright © 2017 Mahbub Ahmed. All rights reserved.
//

#import "MAConstants.h"

@implementation MAConstants

//URL for Login
NSString * const LOGIN_URL=@"https://raw.githubusercontent.com/Mahbub-Ahmed/dummy_data/master/user_data.json";

//'1' for successful login
NSInteger  const LOGIN_SUCCESS=1;

//'2' for unsuccessful login
NSInteger  const LOGIN_FAILED=2;

//'3' for server side login error
NSInteger  const LOGIN_ERROR=3;

//Custom textField Icon size
CGFloat const textFieldIconSize=24;
@end
