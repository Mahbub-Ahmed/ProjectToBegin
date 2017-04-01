//
//  MAContactManager.h
//  ProjectToBegin
//
//  Created by Mahbub Ahmed on 2/14/17.
//  Copyright © 2017 Mahbub Ahmed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Contacts/Contacts.h>
#import <UIKit/UIKit.h>
#import "MAContact.h"
#import <CoreData/CoreData.h>
#import "Contacts+CoreDataClass.h"

@interface MAContactManager : NSObject

//NSManagedObjectContext
@property (strong,nonatomic) NSManagedObjectContext *context;

//Get all contact
-(NSMutableArray *)getContacts;

@end
