//
//  TBRJSONMapper.h
//  TBRJSONMapper
//
//  Created by Nahuel Marisi on 17/02/2015.
//  Copyright (c) 2015 TechBrewers. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface TBRJSONMapper: NSObject

@property (copy, nonatomic) NSString *swiftModuleName;

- (instancetype)initWithSwiftModuleName:(NSString *)swiftModuleName;

- (id)objectGraphForJSONResource:(NSString *)resourcePath withRootClassName:(NSString *)className;
- (id)objectGraphForJSONData:(NSData *)data withRootClassName:(NSString*)className;
- (id)objectGraphForDownloadedJSONResourcePath:(NSString *)resourceName withRootClassName:(NSString *)className;

@end
