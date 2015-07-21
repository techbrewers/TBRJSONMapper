//
//  JSONParser.h
//  CakesAndSweets
//
//  Created by Nahuel Marisi on 12/01/2015.
//  Copyright (c) 2015 Milo Creative. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONParser : NSObject

- (id)objectGraphForJSONResource:(NSString *)resourcePath withRootClassName:(NSString *)className;
- (id)objectGraphForJSONData:(NSData *)data withRootClassName:(NSString*)className;

// Kept for compatiblity reasons (they both assume root class is Recipe).
- (id)objectGraphForJSONResource:(NSString *)resourcePath;
- (id)objectGraphForJSONData:(NSData *)data;

// Loads recipe json stored in Library/Cache
- (id)objectGraphForDownloadedJSONRecipe:(NSString *)recipeName;


@end
