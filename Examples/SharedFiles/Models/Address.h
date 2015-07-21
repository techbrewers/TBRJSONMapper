//
//  Address.h
//  BasicExample
//
//  Created by Nahuel Marisi on 2015-07-21.
//  Copyright (c) 2015 TechBrewers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Address : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *company;
@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *email;
@property (copy, nonatomic) NSString *jobTitle;
@property (strong, nonatomic) NSNumber *partTime;

// One-to-many relationship
@property (strong, nonatomic) NSArray *phones;

@end
