//
//  Contacts+CoreDataProperties.m
//  
//
//  Created by Mahbub Ahmed on 3/31/17.
//
//  This file was automatically generated and should not be edited.
//

#import "Contacts+CoreDataProperties.h"

@implementation Contacts (CoreDataProperties)

+ (NSFetchRequest<Contacts *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Contacts"];
}

@dynamic email;
@dynamic first_name;
@dynamic last_name;
@dynamic image;
@dynamic number;

@end
