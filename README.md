# ProjectToBegin 

<!---ProjectToBegin 
Created by Mahbub Ahmed on 3/20/2017
Copyright © 2017 Mahbub Ahmed. All rights reserved.
-->

[![Platform](https://img.shields.io/badge/platform-ios-lightgrey.svg)]()
[![Programming Language](https://img.shields.io/badge/language-objective--c-ff69b4.svg)]()
[![license](https://img.shields.io/github/license/mashape/apistatus.svg?maxAge=2592000)](/LICENSE.md)

ProjectToBegin is a Simple project to cover a list of useful things that will help you to begin your objective C project. It also has some advance features to show how you can customize views and extend more in depth so that even a beginner can learn quickly or a moderate user can start a simple project easily.

##### The main features of this project includes the below:

-	[Project Folder Structure](#project-folder-structure)  
-	[Custom UITextField](#custom-uitextfield)  
-	[UITableView With Custom Cell](#uitableview-with-custom-cell)  
- [Handling Form](#handling-form)  
  - [Form Data Validating](#form-data-validating)    
  -	[Displaying Error Message](#displaying-error-message)  
- [Submit data to API and handle JSON response](#submit-data-to-api-and-handle-json-response)  
- [Dealing with  NSUserDefaults](#dealing-with-nsuserdefaults)
- [Get Access to Phone Contact](#get-access-to-phone-contact)
- [Core Data](#core-data)
- [CocoaPods](#cocoapods)
-	[Contribution](#contribution)
-	[License](#license)

## Example Login Informaiton  
For example purpose the password is not encrypted  
Use the bellow file contain demo login information to sign in
* [Demo Login](https://raw.githubusercontent.com/Mahbub-Ahmed/dummy_data/master/user_data.json)

## Project Folder Structure
Organising the project files is important for easily accessible codes and to maintain a good quality code. You can choose from a vast range of structures, however this structure is my preference for most of my projects.


```
├── Application           # Application/App is the generic way to define your main app folder without giving a name. This folder should be use for AppDelegate, Stroyboard and Config. I used ProjectToBegin instant of Application. 
├── Constants             # Create separate constants file for purpose 
├── Utilites              # All helper fiels should be inside Utilites. For big project I change the folder name to Helpers 
├── Resource              # Image and other static files
├── Components            # The stand alone class(Service) or group of dependant class, you can use Services too. Sometime is use Services for all single tone classes. I usually use component to define my own libraries/classes or extend third party classes
├── Models                # Class to represent data for example Core Data classes
├── UI                    # UI related classes
├── ├── Controllers       # View controllers 
├── ├── Views             # Custom UI views and view related other classes
├── Libraries             # For any third party libraries that is not possible with dependency manager. 
``` 


## Custom UITextField
Custom UITextField is used to make changes on the default input style and add additional features. Most of the input field will have validation, to display these validation error we need to add error label manually for each field, but with custom TextField so we can do it once and use this custom field as many times as we want.
* [Custom UITextField](https://github.com/Mahbub-Ahmed/ProjectToBegin/tree/master/UI/Views/CustomTextFields)

## UITableView With Custom Cell
Table view is one of the most widly used component in Objective C to display any types of list. Custom UITableView cell allows you to edit your default cell as well as enabling you to display diffrent types of cells in one table view. 
* [Custom UITableViewCell](https://github.com/Mahbub-Ahmed/ProjectToBegin/tree/master/UI/Views/CustomTableViewCell)

## Handling Form

### Form Data Validating
Everyone who uses forms must have some way to validate user input. The best way to do the validation is to create a validation classs that can accecss rule from your input field that will increase reusablity of the code. But here I used the most simplest way so that it is easy for beginners. I used one validation function for each input, then used some regular expressions to validate.  
* [Form Validation](https://github.com/Mahbub-Ahmed/ProjectToBegin/blob/master/Components/Validation.m)

### Displaying Error Message
My custom input field allows me easy accecss to directy set the validation message from validation class.  

###### Bellow method is used to set custom text field error message
``` objective-c
  -(void)setErrorMessage:(NSString *)message;
```

## Submit data to API and handle JSON response
Most of the current applications are needed to connect to API either to send data to server or receive data from server. AFNetworking is a useful library to make this simple. I do not have any server so I used GitHub to get some JSON formated data to show how easily we can connect to server. This is a small example for handling JSON data.
* [API & JSON Response Handle](https://github.com/Mahbub-Ahmed/ProjectToBegin/blob/master/Components/Auth.m)

## Dealing with NSUserDefaults
NSUserDefaults are used to store small amounts of data in your app, for example, if you want to store some information like login status, app setting, preferences, then you can use NSUserDefaults to store data like a key value store.  

###### Bellow code will store user data in NSUserDefaults
``` objective-c
    [[NSUserDefaults standardUserDefaults]setObject:name forKey:@"user_name"];
    [[NSUserDefaults standardUserDefaults]setObject:email forKey:@"user_email"];
    [[NSUserDefaults standardUserDefaults]setBool:true forKey:@"logInStatus"];
    [[NSUserDefaults standardUserDefaults]synchronize];
```
###### In AppDelegate bellow code is used to check if user data is sored in NSUserDefault ,And if so user is navigated to "HOME_VIEW" instead of "LOGIN_VIEW" 
``` objective-c
     if([[NSUserDefaults standardUserDefaults] boolForKey:@"logInStatus"]){
          UINavigationController *navigationController = (UINavigationController *) self.window.rootViewController;
          UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
          [navigationController pushViewController:[storyboard instantiateViewControllerWithIdentifier:@"HOME_VIEW"] animated:NO];
      }
```

## Get Access to Phone Contact
To access user private information like contact, photos, calendar you need to ask the user permission. You can do it very easily using info.plist and later you can check access permission programatically (N.B: to get contact accecss permission you need to add __Privacy - Contacts Usage Description__ in info.plist). I wanted to store user contact localy in my app rather than reading it from contact everytime. Also I wanted some other additional information, so a local databse is the best choice. When the application launches first time I can ask for accecss contact and store all the information in my local database and always read from my local db.

######  The code bellow is used to check user contact access permission
``` objective-c
  -(BOOL) getAuthorizationStatus{
      __block BOOL flag=true;
      CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
      if(status==CNAuthorizationStatusDenied || status == CNAuthorizationStatusRestricted){
          return false;
      }
      CNContactStore *store = [[CNContactStore alloc] init];
      [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error){
          if (!granted) {
              flag=false;
              return ;
          }
      }];
      return flag;
}
```
## Core Data
Core data allows data modeling. If you are working with databse, data modeling makes life much easier. I used SQLite to store my contact list using Core Data. Also have a CRUD example .(N.B: SQLite is default persistent store for core data)
* [Core Data](https://developer.apple.com/reference/coredata)

## CocoaPods
Using dependency manager is the easiest way to install and update any third party libraries you may want to use in your project. I personaly like CocoaPods for objective C.
* [CocoaPods](https://cocoapods.org/)

## Contribution
If you'r interested in contribution you are more than wellcome, Please  
 1. Fork the Repository
 2. Clone it (clone this repository to your machine)
 3. Create a Branch
 4. Edit and make necessary changes. Commit & push those changes
 5. Submit your review
 
## License
ProjectToBegin is licensed under the terms of the MIT License. For full details please see the [LICENSE](https://github.com/Mahbub-Ahmed/ProjectToBegin/blob/master/LICENSE)
