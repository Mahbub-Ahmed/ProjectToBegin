//
//  Auth.m
//  ProjectToBegin
//
//  Created by Mahbub Ahmed on 2/12/17.
//  Copyright © 2017 Mahbub Ahmed. All rights reserved.
//

#import "Auth.h"
#import "MAConstants.h"

@implementation Auth

//Log in with email & password
//Completion block used for call back after response from server
-(void)loginWithEmail:(NSString *)email password:(NSString*) pass completion:(void (^)(NSInteger))completionBlock{
    
    //initlizing AF Network session manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //Initiating the progress view
    [SVProgressHUD show];
    
    //Make get requst to get all user data from server
    //As an example i am getting all user data but in real life you should do this in server side and only login user
    [manager GET:LOGIN_URL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSError *error;
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
        
        //As i got all user data so i will loop through all user data to find user
        //that shows how  to loop throught a josn object
        for(NSDictionary *user in array){
            
            //email and password matched means we got the correct user
            if([email isEqual:[user objectForKey:@"email"]] && [pass isEqual:[user objectForKey:@"password"]]){
                
                //get name from current login user
                NSString *name=[user objectForKey:@"user_name"];
                
                //store login user data in NSDefault so that we can access them later if we need
                [self setUserLoginSuccess:name email:email];
                
                //Match found an now the loing success is set, call back with navigate to home page
                completionBlock(LOGIN_SUCCESS);
                
                //dismiss the progress view
                [SVProgressHUD dismiss];
                return ;
            }
        }
        
        //Complition without any match found
        completionBlock(LOGIN_FAILED);
        
        //dismiss the progress view
        [SVProgressHUD dismiss];
        

    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        //login faild with error
        completionBlock(LOGIN_ERROR);
        
        //dismiss the progress view
        [SVProgressHUD dismiss];
        
        //print the error 
        NSLog(@"Login Server Error: %@", error);
    }];
}


//Saving user data to default
-(void)setUserLoginSuccess:(NSString*)name email:(NSString*)email {
    
    //on success you may get token from server to store to make other api call
    //or store password in keychain so that you can make other api call
    
    [[NSUserDefaults standardUserDefaults]setObject:name forKey:@"user_name"];
    [[NSUserDefaults standardUserDefaults]setObject:email forKey:@"user_email"];
    
    //set loing status that will be chaked by other proces to see if user login
    [[NSUserDefaults standardUserDefaults]setBool:true forKey:@"logInStatus"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

//user login status
-(BOOL)isLogin{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"logInStatus"];
}

//Return user name
-(NSString*)getUserName{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"user_name"];
}

//Return user email
-(NSString*)getUserEmail{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"user_email"];
}

//log out user and remove user data from nsdefault
-(void)logOut{
    
    // **Use the bellow comment out code block if you want to clear all UserDefaults **
    /*
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    */
    
    //Reset user default
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"user_name"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"user_email"];
    
    //remove user login status
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"logInStatus"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
}
@end
