//
//  Recipe.h
//  NordicCook
//
//  Created by Nahuel Marisi on 17/02/2015.
//  Copyright (c) 2015 TechBrewers. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const kStarterCategory;
FOUNDATION_EXPORT NSString *const kMainCategory;
FOUNDATION_EXPORT NSString *const kDessertCategory;
FOUNDATION_EXPORT NSString *const kAllRecipesCategory;


@interface Recipe : NSObject

#pragma message ("Properties should be readonly since objects should be immutable")

// JSON properties
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *abstract;
@property (nonatomic, copy) NSString *tip;
@property (nonatomic, strong) NSNumber *time;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *copyright;
@property (nonatomic, copy) NSArray *steps;
@property (nonatomic, strong) NSNumber *stepImagesAvailable;

// Derived properties
@property (nonatomic, copy) NSString *imagePath;
@property (nonatomic, copy) NSString *thumbnailImagePath;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, readonly) BOOL hasStepImages;
/**
 *  Return the array of unique ingredients sorted alphabetically and split by
 *  ingredients with and without quantity
 *
 *  @return Array of ingredients
 */
- (NSArray *)ingredients;

/**
 *  Return the array of recipe category string constants.
 *
 *  @return Array of category string contants
 */
+ (NSArray *)categoriesArray;

+ (NSString *)categoryForIndex:(int)index;


@end
