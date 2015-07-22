//
//  TBRJSONMapper.h
//  TBRJSONMapper
///
//  Created by Nahuel Marisi on 17/02/2015.
//  Copyright (c) 2015 TechBrewers. All rights reserved.
//

#import "TBRJSONMapper.h"

#define pragma mark - Utility category
@interface NSString (Utilities)
- (NSString *)lowercaseFirstLetter;
@end

@implementation NSString (Utilities)


#pragma mark - NSString (Utilities) Public methods
- (NSString *)lowercaseFirstLetter
{
    NSString *firstLetter = [self foldedFirstChracterInString];
    return [[firstLetter lowercaseString] stringByAppendingString:[self substringFromIndex:1]];
}

#pragma mark - NSString (Utilities) Private methods
- (NSString *)foldedFirstChracterInString
{
    // Ceate a locale where diacritic marks are not considered important, e.g. US English
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en-US"];
    
    NSString *firstChar = [self substringToIndex:1];
    
    // Remove any diacritic mark
    NSString *folded = [firstChar stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:locale];
    return folded;
}

@end

#pragma mark - TBRJSONMapper implementation methods
@implementation TBRJSONMapper

- (instancetype)initWithSwiftModuleName:(NSString *)swiftModuleName
{
    self = [super init];
    if (self) {
        _swiftModuleName = [swiftModuleName stringByAppendingString:@"."];
    }
    
    return self;
}

- (id)objectGraphForJSONResource:(NSString *)resourcePath withRootClassName:(NSString *)className
{
    NSString *jsonFilePath =
    [[NSBundle mainBundle] pathForResource:resourcePath ofType:@"json"];
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:jsonFilePath];
    
    // Shouldn't it return nil instead?
    NSAssert(data != nil, @"Unable to load JSON file.");
    
    return [self objectGraphForJSONData:data withRootClassName:className];
    
}

// ADD Method for local cache directory to example

- (id)instantiateClassFromName:(NSString *)className
{
    Class rootObjectClass = NSClassFromString(className);
    
    // If class doesn't exist, it might be a swift class
    if (!rootObjectClass) {
        NSString *swiftClassName = [self.swiftModuleName stringByAppendingString:className];
        rootObjectClass = NSClassFromString(swiftClassName);
    }
    
    id newObject = [[rootObjectClass alloc] init];
    NSAssert(newObject != nil, @"Unable to instantiate class:%@", className);
    
    return newObject;
    
}

- (id)objectGraphForJSONData:(NSData *)data withRootClassName:(NSString*)className
{
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSDictionary *objectDictionary = [json objectForKey:className];
    
    NSAssert(objectDictionary != nil, @"Unable to load dictionary for class:%@", className);
    
    // Instantiate a new root object
    id newObject = [self instantiateClassFromName:className];
    
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
                
                for (NSDictionary *dictionary in oneToManyArray) {
                    
                    
                    // Create new object based on the class name.
                    id newEmbeddedObject = [self instantiateClassFromName:className];
                    
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
                             forKey:key.lowercaseFirstLetter];
                
            } else { //one-to-one
                Class embeddedObjectClass = NSClassFromString(key);
                id newEmbeddedObject = [[embeddedObjectClass alloc] init];
                [self processObject:newEmbeddedObject
                     withDictionary:[objectDictionary objectForKey:key]];
            }
            
        }
    }
}

@end


