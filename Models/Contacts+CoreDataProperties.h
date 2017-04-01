//
//  Contacts+CoreDataProperties.h
//  
//
//  Created by Mahbub Ahmed on 3/31/17.
//
//  This file was automatically generated and should not be edited.
//

#import "Contacts+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Contacts (CoreDataProperties)

+ (NSFetchRequest<Contacts *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSString *first_name;
@property (nullable, nonatomic, copy) NSString *last_name;
@property (nullable, nonatomic, copy) NSString *image;
@property (nullable, nonatomic, copy) NSString *number;

@end

NS_ASSUME_NONNULL_END
