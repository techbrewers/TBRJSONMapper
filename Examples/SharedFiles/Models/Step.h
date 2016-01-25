//
//  Step.h
//  NordicCook
//
//  Created by Nahuel Marisi on 17/02/2015.
//  Copyright (c) 2015 TechBrewers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Step : NSObject

// JSON properties
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSArray *ingredients;

@end
