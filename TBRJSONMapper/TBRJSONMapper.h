//
//  JSONMapper.h
//  NordicCook
//
//  Created by Nahuel Marisi on 17/02/2015.
//  Copyright (c) 2015 TechBrewers. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface JSONMapper: NSObject

- (id)objectGraphForJSONResource:(NSString *)resourcePath withRootClassName:(NSString *)className;
- (id)objectGraphForJSONData:(NSData *)data withRootClassName:(NSString*)className;

// Kept for compatiblity reasons (they both assume root class is Recipe).
- (id)objectGraphForJSONResource:(NSString *)resourcePath;
- (id)objectGraphForJSONData:(NSData *)data;


@end
