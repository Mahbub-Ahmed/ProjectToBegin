//
//  AddContactViewController.m
//  ProjectToBegin
//
//  Created by Mahbub Ahmed on 2/19/17.
//  Copyright © 2017 Mahbub Ahmed. All rights reserved.
//

#import "MAAddContactViewController.h"
#import "AppDelegate.h"
@interface MAAddContactViewController ()

@end

@implementation MAAddContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //setting view
    [self setupView];
    
    //seting textfield delegate
    [self setupDelegate];
}

//seting textfield delegate
-(void)setupDelegate{
    _firstNameField.delegate=self;
    _lastNameField.delegate=self;
}

-(void)setConstraint{
    _imageYValConstraint.constant=10;
}

//set view 
-(void)setupView{
    //by default save button is disable
    _saveButton.enabled=NO;
    
    //rounding the add image button
    self.addImageButton.layer.cornerRadius=self.addImageButton.frame.size.width/2;
    self.addImageButton.layer.borderWidth=2.0f;
    self.addImageButton.layer.borderColor=[UIColor grayColor].CGColor;
    self.addImageButton.clipsToBounds=YES;
    
    //setting place holder for text fields
    _firstNameField.placeholder=@"First Name";
    _lastNameField.placeholder=@"Last Name";
    _phoneNumberField.placeholder=@"Cell";
    
    //Changing text field place holder color
    [_firstNameField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    [_lastNameField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    [_phoneNumberField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - textField delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    //removig the place holder when user start typing
    if(textField==_firstNameField){
        //[_firstNameField setPlaceHolderLabel:@""];
        _firstNameField.placeholder=@"";
    }
    else if(textField==_lastNameField){
        //[_lastNameField setPlaceHolderLabel:@""];
         _lastNameField.placeholder=@"";
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    //if textfield not empty enable the save button
    //so that user can save an non empty contact
    if(![_firstNameField.text isEqual:@""] || ![_lastNameField.text isEqual:@""]){
        _saveButton.enabled=YES;
    }
    else{
        _saveButton.enabled=NO;
        //[_firstNameField setPlaceHolderLabel:@"First Name"];
        //[_lastNameField setPlaceHolderLabel:@"Last Name"];
        _firstNameField.placeholder=@"First Name";
         _lastNameField.placeholder=@"Last Name";
    }
    [textField resignFirstResponder];
}

#pragma mark - Save button action

- (IBAction)saveContact:(id)sender {
    
    NSManagedObjectContext *context=[[(AppDelegate *)[[UIApplication sharedApplication] delegate] persistentContainer] viewContext];
    [context reset];
    
    //initilizing contact object to save contact in database
    Contacts *contact=(Contacts*) [NSEntityDescription insertNewObjectForEntityForName:@"Contacts"inManagedObjectContext:context];
    
    //storing textfield value to contact
    contact.first_name=_firstNameField.text;
    contact.last_name=_lastNameField.text;
    contact.number=_phoneNumberField.text;
    contact.email=_emailField.text;
    contact.image=@"profileImage";
    
    NSError *error;
    if(![context save:&error]){
        NSLog(@"Unable to save Contact, %@",error);
    }
    
    //After saving the contact , naivgating user to home page
    UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HOME_VIEW"];
    [self.navigationController pushViewController:newViewController animated:YES];
}

//To add image for contact
- (IBAction)addImage:(id)sender {
}

@end
