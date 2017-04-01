//
//  ContactViewController.h
//  ProjectToBegin
//
//  Created by Mahbub Ahmed on 2/14/17.
//  Copyright © 2017 Mahbub Ahmed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAContact.h"
#import "MATableViewCell.h"
#import "MAContactManager.h"
#import "MADetailViewController.h"

@interface MAContactViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

//search controller
@property (strong, nonatomic) UISearchController *searchController;

//contact table
@property (strong, nonatomic) IBOutlet UITableView *tableView;

//button to add new contact
@property (strong ,nonatomic) UIButton *addButton;

@end
