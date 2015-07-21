//
//  Step.m
//  NordicCook
//
//  Created by Nahuel Marisi on 17/02/2015.
//  Copyright (c) 2015 TechBrewers. All rights reserved.
//

#import "Step.h"
#import "Macros.h"
#import "IngredientsSorter.h"

@implementation Step

- (NSArray *)sortedIngredients
{
  return [IngredientsSorter sortedIngredientsArrayFromArray:self.ingredients];
}

- (NSString *)description
{
  return description(SelfKeyPath(number),
                     SelfKeyPath(text),
                     SelfKeyPath(ingredients),
										 SelfKeyPath(imagePath));
}

@end
