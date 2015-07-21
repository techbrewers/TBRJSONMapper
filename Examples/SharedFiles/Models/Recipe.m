//
//  Recipe.m
//  NordicCook
//
//  Created by Nahuel Marisi on 17/02/2015.
//  Copyright (c) 2015 TechBrewers. All rights reserved.
//

#import "Recipe.h"
#import "Step.h"
#import "Macros.h"
#import "Ingredient.h"
#import "IngredientsSorter.h"

NSString *const kStarterCategory = @"Starter";
NSString *const kMainCategory = @"Main";
NSString *const kDessertCategory = @"Dessert";
NSString *const kAllRecipesCategory = @"AllRecipes";

@implementation Recipe

#pragma mark - Helpers

+ (NSArray *)categoriesArray
{
    return @[kStarterCategory, kMainCategory, kDessertCategory,
             kAllRecipesCategory];
}

+ (NSString *)categoryForIndex:(int)index
{
    NSArray *categories = [self categoriesArray];
    return categories[index];
}

- (NSArray *)ingredients
{
  NSMutableSet *ingredientsArray = [NSMutableSet new];
  for (Step *step in self.steps) {
    [ingredientsArray addObjectsFromArray:step.ingredients];
  }
  
  NSArray *uniqueIngredientsArray = [ingredientsArray allObjects];
  return [IngredientsSorter sortedIngredientsArrayFromArray:uniqueIngredientsArray];
}

- (BOOL)hasStepImages
{
	return self.stepImagesAvailable.boolValue;
}

#pragma mark - Overrides

- (NSString *)description
{
  return description(
										 SelfKeyPath(name),
                     SelfKeyPath(title),
                     SelfKeyPath(subtitle),
                     SelfKeyPath(category),
                     SelfKeyPath(copyright),
                     SelfKeyPath(ingredients),
										 SelfKeyPath(imagePath),
										 SelfKeyPath(hasStepImages),
										 SelfKeyPath(abstract),
										 SelfKeyPath(tip),
										 );
}

@end
