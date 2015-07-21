//
//  Ingredient.m
//  NordicCook
//
//  Created by Nahuel Marisi on 17/02/2015.
//  Copyright (c) 2015 TechBrewers. All rights reserved.
//http://www.rindlow.se/foto/2005-12-19

#import "Ingredient.h"
#import "Macros.h"

@implementation Ingredient

#pragma mark - Public methods

- (NSString *)displayedQuantityWithMultiplier:(NSUInteger)multiplier
{
	if (!self.quantity) {
		return nil;
	}
	
	NSString *ingredientQuantityString = [NSString stringWithFormat:@"%lu", (unsigned long)self.quantity.integerValue * multiplier];
	if (!self.quantityUnit.length) {
		return ingredientQuantityString;
	}
	return [NSString stringWithFormat:@"%@ %@", ingredientQuantityString, self.quantityUnit];
}

#pragma mark - Overrides

- (NSString *)description
{
  return description(SelfKeyPath(name),
                     SelfKeyPath(quantity),
                     SelfKeyPath(quantityUnit));
}

#pragma mark - Equality

- (BOOL)isEqualToIngredient:(Ingredient *)ingredient
{
  if (!ingredient) {
    return NO;
  }
  BOOL haveEqualNames = (!self.name && !ingredient.name) || [self.name isEqualToString:ingredient.name];
  BOOL haveEqualQuantity = (!self.quantity && !ingredient.quantity);
  if (ingredient.quantity) {
    haveEqualQuantity = [self.quantity isEqualToNumber:ingredient.quantity];
  }
  BOOL haveEqualQuantityUnit = (!self.quantityUnit && !ingredient.quantityUnit) || [self.quantityUnit isEqualToString:ingredient.quantityUnit];
  
  return haveEqualNames && haveEqualQuantity && haveEqualQuantityUnit;
}

- (BOOL)isEqual:(id)object {
  if (self == object) {
    return YES;
  }
  
  if (![object isKindOfClass:[Ingredient class]]) {
    return NO;
  }
  
  return [self isEqualToIngredient:(Ingredient *)object];
}

- (NSUInteger)hash
{
  return self.name.hash ^ self.quantity.hash ^ self.quantityUnit.hash;
}

@end
