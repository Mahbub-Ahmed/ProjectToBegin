//
//  DetailViewController.m
//  ProjectToBegin
//
//  Created by Mahbub Ahmed on 2/17/17.
//  Copyright © 2017 Mahbub Ahmed. All rights reserved.
//

#import "MADetailViewController.h"
#import "Helper.h"
@interface MADetailViewController ()

@end

@implementation MADetailViewController
@synthesize contact;
- (void)viewDidLoad {
    [super viewDidLoad];
 
    NSString *fullName=[NSString stringWithFormat:@"%@ %@",contact.first_name,contact.last_name];
    
    //showing the passed contact property in detail view fields
    _nameLabel.text=fullName;
    _numberLabel.text=contact.number;
    _emailLabel.text=contact.email;
    
    //rounding the contact image
    _contactImage.layer.cornerRadius = _contactImage.frame.size.width / 2;
    _contactImage.layer.borderWidth = 2.0f;
    _contactImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _contactImage.clipsToBounds = YES;
    
    //resizing image by width using helper class method
    _contactImage.image=[Helper resizeImageByWidth:[UIImage imageNamed:contact.image] width:140];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Sending selected contact to edit view controller when user click edit button
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"editView"]) {
        MAEditContactViewController *destViewController = segue.destinationViewController;
        destViewController.contact=contact;
    }
}


@end
