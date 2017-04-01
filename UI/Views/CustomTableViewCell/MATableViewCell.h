//
//  MATableViewCell.h
//  ProjectToBegin
//
//  Custom UITableView Cell
//
//  Created by Mahbub Ahmed on 2/14/17.
//  Copyright © 2017 Mahbub Ahmed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MATableViewCell : UITableViewCell

//contact name
@property (strong, nonatomic) IBOutlet UILabel *contactNameLabel;
//contact number
@property (strong, nonatomic) IBOutlet UILabel *contactNumberLabel;

//contact image
@property (strong, nonatomic) IBOutlet UIImageView *contactImage;


@end
