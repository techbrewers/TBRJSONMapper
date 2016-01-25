//
//  Recipe.h
//  NordicCook
//
//  Created by Nahuel Marisi on 17/02/2015.
//  Copyright (c) 2015 TechBrewers. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Ingredient;

@interface Recipe : NSObject

// JSON properties
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *abstract;
@property (nonatomic, copy) NSString *tip;
@property (nonatomic, strong) NSNumber *time;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *copyright;
@property (nonatomic, strong) Ingredient *ingredient;

@property (nonatomic, copy) NSArray *steps;
@property (nonatomic, strong) NSNumber *stepImagesAvailable;

@end
