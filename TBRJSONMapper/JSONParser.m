//
//  JSONParser.m
//  CakesAndSweets
//
//  Created by Nahuel Marisi on 12/01/2015.
//  Copyright (c) 2015 Milo Creative. All rights reserved.
//

#import "JSONParser.h"
#import "Recipe.h"
#import "Step.h"
#import "Ingredient.h"
#import "Tip.h"

#define KeyPath(type, keyPath) ({ if(NO){((type)nil).keyPath;} @#keyPath; })

@implementation JSONParser

- (id)objectGraphForDownloadedJSONRecipe:(NSString *)recipeName
{
    NSString *cacheDir =
    [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *storePath = [cacheDir stringByAppendingPathComponent:recipeName];
    
    NSData *data = [[NSFileManager defaultManager]
                    contentsAtPath:[storePath stringByAppendingPathComponent:@"recipe.json"]];

    return [self objectGraphForJSONData:data withRootClassName:@"Recipe"];
}

- (id)objectGraphForJSONResource:(NSString *)resourcePath
{
    return [self objectGraphForJSONResource:resourcePath
                          withRootClassName:@"Recipe"];
    
}

- (id)objectGraphForJSONResource:(NSString *)resourcePath withRootClassName:(NSString *)className
{
    NSString *jsonFilePath =
    [[NSBundle mainBundle] pathForResource:resourcePath ofType:@"json"];
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:jsonFilePath];
    
    return [self objectGraphForJSONData:data withRootClassName:className];
    
}

- (id)objectGraphForJSONData:(NSData *)data
{
    return [self objectGraphForJSONData:data
                      withRootClassName:@"Recipe"];
}

- (id)objectGraphForJSONData:(NSData *)data withRootClassName:(NSString*)className
{
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSDictionary *objectDictionary = [json objectForKey:className];
    
    // Instantiate a new root object
    Class rootObjectClass = NSClassFromString(className);
    id newObject = [[rootObjectClass alloc] init];
    
    [self processObject:newObject withDictionary:objectDictionary];
    
    return newObject;
}

- (void)processObject:(id)newObject withDictionary:(NSDictionary *)objectDictionary
{
    for (NSString *key in objectDictionary) {
        
        BOOL isUppercase = [[NSCharacterSet uppercaseLetterCharacterSet]
                            characterIsMember:[key characterAtIndex:0]];
        
        // It's a property of the object rather than an embedded object
        if (!isUppercase) {
            
            SEL selector = NSSelectorFromString(key);
            if ([newObject respondsToSelector:selector]) {
                [newObject setValue:[objectDictionary valueForKey:key]
                             forKey:key];
            }
        } else { // if uppercase then it's an embedded object and requires a new class.
           
           
            // Is it a one-to-one or a one-to-many relationship?
            
            // if it has an array it's a one-to-many
            if ([[objectDictionary objectForKey:key] isKindOfClass:[NSArray class]]) {
                NSArray *oneToManyArray = [objectDictionary objectForKey:key];
                
                // Create array for one-to-many
                
                NSMutableArray *oneToManyRelationship = [[NSMutableArray alloc]
                                                         init];
                
                  // The class for the object in the relationship wouldn't be plural.
                  // So for example, if the key is Ingredients, the object
                  // class must be Ingredient
                  NSString *className = [key substringToIndex:[key length] - 1];
                 Class embeddedObjectClass = NSClassFromString(className);
                
                 for (NSDictionary *dictionary in oneToManyArray) {
                    
                  
                    // Create new object based on the class name.
                    id newEmbeddedObject = [[embeddedObjectClass alloc] init];
                    
                     [self processObject:newEmbeddedObject
                         withDictionary:dictionary];
                    
                    // Add to one-to-many array
                    [oneToManyRelationship addObject:newEmbeddedObject];
                }
                
                // Set the array containing the one-to-many related objects
                // property name would be all lowercase
                // TODO: it should deal with camel case, ie specialEquipments
                // Perhaps provide a function that converts key to ivar name
                [newObject setValue:oneToManyRelationship
                             forKey:[self lowerCaseFirstLetter:key]];
                
            } else { //one-to-one
                Class embeddedObjectClass = NSClassFromString(key);
                id newEmbeddedObject = [[embeddedObjectClass alloc] init];
                     [self processObject:newEmbeddedObject
                     withDictionary:[objectDictionary objectForKey:key]];
            }
            
        }
    }

}

- (NSString *)lowerCaseFirstLetter:(NSString *)input
{
    /* create a locale where diacritic marks are not considered important, e.g. US English */
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en-US"];
    
    /* get first char */
    NSString *firstChar = [input substringToIndex:1];
    
    /* remove any diacritic mark */
    NSString *folded = [firstChar stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:locale];
    
    /* create the new string */
    return [[folded lowercaseString] stringByAppendingString:[input substringFromIndex:1]];
}



@end
