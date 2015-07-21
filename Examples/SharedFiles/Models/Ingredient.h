//
//  Ingredient.h
//  NordicCook
//
//  Created by Nahuel Marisi on 17/02/2015.
//  Copyright (c) 2015 TechBrewers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ingredient : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *quantity;
@property (nonatomic, copy) NSString *quantityUnit;

- (NSString *)displayedQuantityWithMultiplier:(NSUInteger)multiplier;

@end
