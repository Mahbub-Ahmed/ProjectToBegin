//
//  MAContactManager.m
//  ProjectToBegin
//
//  Created by Mahbub Ahmed on 2/14/17.
//  Copyright © 2017 Mahbub Ahmed. All rights reserved.
//

#import "MAContactManager.h"
#import "AppDelegate.h"


@implementation MAContactManager{
    NSMutableArray *phoneContacts;
    NSArray *contacts;
}


-(NSArray *)getContacts{
    
    //if contact is not empty return all contacts
    if(contacts!=nil){
        
        return contacts;
    }
    _context=[[(AppDelegate *)[[UIApplication sharedApplication] delegate] persistentContainer] viewContext];
    contacts=[[NSArray alloc]init];
    
    //To delete all contact
    //[self deleteAllContact];
    
    //Check if the app launching for first time..
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
    {
         //Launchig  frist time,so request to save all the phone contact to database
        //And set the flag for already launched once to true
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // save phone contacts to database
        [self savePhoneContactsToDatabase];
    }
    
    //get all available contacts from database
    [self getContactsFromDatabase];

    return contacts;
}

//Saving all phone contact to database
//I am useing coredata to save the data
-(void)savePhoneContactsToDatabase{
    
    //Authorization to access contact is denined
    if(![self getAuthorizationStatus]){
        return ;
    }
    CNContactStore *store = [[CNContactStore alloc] init];

    //Keys for all the contact properties you want to fatch from phone contact
    NSArray *keys = @[CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey,CNContactEmailAddressesKey];
    
    //initilizing featchRequest uisng defined keys
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
    NSError *error;
    
    __block NSInteger index=0;
    
    [store enumerateContactsWithFetchRequest:request error:&error usingBlock:^(CNContact * __nonnull contact, BOOL * __nonnull stop) {
        
        if (error) {
            NSLog(@"error fetching contacts %@", error);
        } else{
            
            index+=1;
            
            //Initilizing a Contact object to save the contact in databse
            Contacts *phoneContact=[NSEntityDescription insertNewObjectForEntityForName:@"Contacts"inManagedObjectContext:_context];
            
            //Phone number
            NSString *number= [[[contact.phoneNumbers firstObject] value] stringValue];
            
            //Email
            NSString *email=[[contact.emailAddresses firstObject] value];
            
            phoneContact.first_name=contact.givenName;
            phoneContact.last_name=contact.familyName;
            phoneContact.email=email;
            phoneContact.number=number;
            
            //Adding random image to simulator default contacts
            phoneContact.image=[NSString stringWithFormat:@"prof%ld.jpg", index];
        }
    }];
    
    error=nil;
    //if no error save all phone contact to database
    if(![_context save:&error]){
        NSLog(@"Unable to save %@",error);
    }
}

//get all saved contact for database
-(void)getContactsFromDatabase{
    
    //Initilize a fatchrequest for contact
    NSFetchRequest *request=[Contacts fetchRequest];
    NSError *error = nil;
    [_context reset];
    NSManagedObjectContext *context=[[(AppDelegate *)[[UIApplication sharedApplication] delegate] persistentContainer] viewContext];
    contacts = [context executeFetchRequest:request error:&error];
    
    //unabel to fatch contacts from database
    if (!contacts) {
        NSLog(@"Error fetching Contact objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
}

//Delete all contact form database using core data
-(void)deleteAllContact{
    //initialize a fatchrequest for contact attribute
    NSFetchRequest *request=[Contacts fetchRequest];
    
    //initialize a batch delete request for contact using contact fatch request
    NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    
    NSError *deleteError = nil;
    
    //excute the delete request
    [_context executeRequest:delete error:&deleteError];
    
    //unabel to delete
    if(deleteError){
        NSLog(@"unable to delete");
    }
}

//get contact authorization before accessing the phone contact to store in database
-(BOOL) getAuthorizationStatus{
    
    __block BOOL flag=true;
    
    //Get authorization Status
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    
    //Authorization status denied or restricted
    if(status==CNAuthorizationStatusDenied || status == CNAuthorizationStatusRestricted){
        return false;
    }
    
    CNContactStore *store = [[CNContactStore alloc] init];
    
    //Authorization not determined yet , request for granting authorization to access contact
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error){
        
        //Authorization not granted
        if (!granted) {
            flag=false;
            return ;
        }
    }];
    return flag;
}
@end
