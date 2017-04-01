//
//  ContactViewController.m
//  ProjectToBegin
//
//  Created by Mahbub Ahmed on 2/14/17.
//  Copyright © 2017 Mahbub Ahmed. All rights reserved.
//

#import "MAContactViewController.h"
#import "AppDelegate.h"
#import "Helper.h"
#import "Auth.h"

@interface MAContactViewController ()

@end

@implementation MAContactViewController{
    NSArray *contactList;
    NSArray *searchedContact;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    MAContactManager *contact=[[MAContactManager alloc]init];
    contactList=[contact getContacts];
    
    //sort all contact by name
    [self sortContactByName];
    
    //set searchbar
    [self setSearchView];
}

//Seting searchbar
-(void)setSearchView{
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater= self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    
    [self.searchController loadViewIfNeeded];
}

//Sorting contacts by name using NSSortDescriptor 
-(void)sortContactByName{
    NSSortDescriptor * sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"first_name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    contactList = [contactList sortedArrayUsingDescriptors:sortDescriptors];
}

//adding custom button to navigation bar back/left button
//And using it to logout user and reset user data
-(void)viewWillAppear:(BOOL)animated{
    UIImage *leftbuttonImage = [UIImage imageNamed:@"sign_out.png"];
    UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbutton setImage:leftbuttonImage forState:UIControlStateNormal];
    leftbutton.frame = CGRectMake(0, 0, 25, 25);
    
    //custom left button action
    [leftbutton addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
    
    [leftbutton setShowsTouchWhenHighlighted:YES];
    UIBarButtonItem *customBarleftItem = [[UIBarButtonItem alloc] initWithCustomView:leftbutton];
    
    //adding cutsom button as navigation bar custom button
    self.navigationItem.leftBarButtonItem = customBarleftItem;
}

//logout user on navigation bar left button click
//And navigate user to login page
-(void)logOut{
    Auth *auth=[[Auth alloc]init];
    //logout user
    [auth logOut];
    
    //navigate user to the login page
    UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LOGIN_VIEW"];
    [self.navigationController pushViewController:newViewController animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -tableView delegate & dataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //Return total matched contact for search if searchbar active and uses searching
    if(self.searchController.active && ![self.searchController.searchBar.text isEqual:@""]){
        return searchedContact.count;
    }
    return [contactList count];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 58;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Contacts *contact=(Contacts*) [NSEntityDescription insertNewObjectForEntityForName:@"Contacts"inManagedObjectContext:[[(AppDelegate *)[[UIApplication sharedApplication] delegate] persistentContainer] viewContext]];
    
    //use searchedContact if searchbar activate and user searching contact
    if(self.searchController.active && ![self.searchController.searchBar.text isEqual:@""]){
        contact=[searchedContact objectAtIndex:indexPath.row];
    }
    //else use all contact
    else{
        contact=[contactList objectAtIndex:indexPath.row];
    }
    
    NSString *cellIdentifier=@"contactCell";
    
    MATableViewCell *cell = (MATableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[MATableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //Rounding the contact image
    cell.contactImage.layer.cornerRadius = cell.contactImage.frame.size.width / 2;
    cell.contactImage.layer.borderWidth = 1.0f;
    cell.contactImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.contactImage.clipsToBounds = YES;
    
    NSString *fullName=[NSString stringWithFormat:@"%@ %@",contact.first_name,contact.last_name];
    
    //adding contact name to the cell name  Label
    cell.contactNameLabel.text=fullName;
    
    //adding contact number to the cell number  Label
    cell.contactNumberLabel.text=contact.number;
    
    //adding contact image
    cell.contactImage.image=[Helper resizeImageByWidth:[UIImage imageNamed:contact.image] width:52];

    return cell;
}

#pragma mark -UISearchResultsUpdating delegate

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = searchController.searchBar.text;
    [self searchForText:searchString scope:searchController.searchBar.selectedScopeButtonIndex];
    [self.tableView reloadData];
}

//Search contact using predicate
- (void)searchForText:(NSString*)searchText scope:(NSInteger)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"first_name contains[c] %@", searchText];
    searchedContact = [contactList filteredArrayUsingPredicate:resultPredicate];
}

//passing data to detail view controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detailView"]) {
        MADetailViewController *destViewController = segue.destinationViewController;
        
        Contacts *selectedContact;
        
        //getting current selected contact indexpath
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        
        //if search bar active ,sned selected contact from seareched contact
        if(self.searchController.active && ![self.searchController.searchBar.text isEqual:@""]){
            selectedContact=[searchedContact objectAtIndex:selectedIndexPath.row];
        }
        else{
            selectedContact=[contactList objectAtIndex:selectedIndexPath.row];
        }
        //Setting back butoon title 
        self.navigationItem.backBarButtonItem.title=@"Contacts";
        
        //pass selected contact to detailview controller
        destViewController.contact=selectedContact;
    }
}




@end
