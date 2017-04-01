//
//  Auth.h
//  ProjectToBegin
//
//  Created by Mahbub Ahmed on 2/12/17.
//  Copyright © 2017 Mahbub Ahmed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import "Helper.h"
#import <SVProgressHUD.h>
#import "MAContact.h"

@interface Auth : NSObject

//Log in with email & password
//Completion block used for call back after response from server
-(void)loginWithEmail:(NSString *)email password:(NSString*) pass completion:(void (^)(NSInteger))completionBlock;

//return login status
-(BOOL)isLogin;

//log out user and remove user data from nsdefault
-(void)logOut;
@end
