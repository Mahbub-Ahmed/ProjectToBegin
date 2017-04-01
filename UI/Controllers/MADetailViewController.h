//
//  DetailViewController.h
//  ProjectToBegin
//
//  Created by Mahbub Ahmed on 2/17/17.
//  Copyright © 2017 Mahbub Ahmed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAContact.h"
#import "MAContactManager.h"
#import "MAEditContactViewController.h"

@interface MADetailViewController : UIViewController

//Contact name
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

//contact number
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;

//contact eamil
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;

//contact image
@property (strong, nonatomic) IBOutlet UIImageView *contactImage;

//contact object to recive selected contact from home view
@property (nonatomic, strong) Contacts *contact;

@end
