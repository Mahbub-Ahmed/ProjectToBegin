//
//  EditContactViewController.m
//  ProjectToBegin
//
//  Created by Mahbub Ahmed on 2/20/17.
//  Copyright © 2017 Mahbub Ahmed. All rights reserved.
//

#import "MAEditContactViewController.h"
#import "AppDelegate.h"
#import "Helper.h"
@interface MAEditContactViewController ()

@end

@implementation MAEditContactViewController
@synthesize contact;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setView];
    
}
-(void)setView{
    //Setting passeed contact property to textfield
    _firstNameField.text=contact.first_name;
    _lastNameField.text=contact.last_name;
    _phoneNumberField.text=contact.number;
    _emailField.text=contact.email;
    
    //Rounding contact image button
    self.changeImageButton.layer.cornerRadius=self.changeImageButton.frame.size.width/2;
    self.changeImageButton.layer.borderWidth=1.0f;
    self.changeImageButton.layer.borderColor=[UIColor grayColor].CGColor;
    self.changeImageButton.clipsToBounds=YES;
    UIImage *image=[Helper resizeImageByWidth:[UIImage imageNamed:contact.image] width:70];
    [_changeImageButton setBackgroundImage:image forState:UIControlStateNormal];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButton:(id)sender {
   
    //Check all the text fields to see if anything change
    if(contact.first_name!=_firstNameField.text || contact.last_name!=_lastNameField.text ||contact.number!=_phoneNumberField.text || contact.email!=_emailField.text){
        
        //change occured
        //so Initilize a fatchrequest to get that specific contact and update it
        
        NSFetchRequest *request=[Contacts fetchRequest];
        NSError *error;
        
        //to edit/update, retrieve the contact by provided key
        //In my case, i am using phone number to find the contact
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"number == %@", contact.number];
        [request setPredicate:predicate];
        
        NSManagedObjectContext *context=[[(AppDelegate *)[[UIApplication sharedApplication] delegate] persistentContainer] viewContext];
        [context reset];
        NSArray *results = [context executeFetchRequest:request error:&error];
        
        //contact match found for provided number, now update that contact change and save
        if(results.count >0){
            
            Contacts* selectedContact = [results objectAtIndex:0];
            selectedContact.first_name=_firstNameField.text;
            selectedContact.last_name=_lastNameField.text;
            selectedContact.number=_phoneNumberField.text;
            selectedContact.email=_emailField.text;
            
            //selectedContact.image=@"joker.jpg";
            [context save:nil];
        }
        
    }
    
    //after saving edit, navigate user to home view
    UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HOME_VIEW"];
    [self.navigationController pushViewController:newViewController animated:YES];
    
}
//add action to change contact image
- (IBAction)changeImage:(id)sender {
}



@end
