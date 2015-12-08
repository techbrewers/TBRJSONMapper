//
//  UnitTests.m
//  UnitTests
//
//  Created by Nahuel Marisi on 2015-07-28.
//  Copyright (c) 2015 TechBrewers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "TBRJSONMapper.h"
#import "Address.h"
#import "Phone.h"

@interface UnitTestsTests : XCTestCase

@property (strong, nonatomic) NSArray *jsonFiles;
@property (strong, nonatomic) NSArray *classNames;

@end

@implementation UnitTestsTests

- (void)setUp {
    [super setUp];
    
    self.jsonFiles = @[@"address",
                       @"fleskfile_recipe",
                       @"kalops_recipe",
                       @"kotbullar_recipe"
                       ];
    
    self.classNames = @[@"Address",
                        @"Recipe",
                        @"Recipe",
                        @"Recipe"
                        ];
    
    
}

- (void)tearDown {
    self.jsonFiles = nil;
    
    [super tearDown];
}

- (void)testLoadJSONFiles {
    
    for (NSString *jsonFile in self.jsonFiles) {
        
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSString *jsonFilePath = [bundle pathForResource:jsonFile ofType:@"json"];
        
        TBRJSONMapper *mapper = [[TBRJSONMapper alloc] init];
        
        NSString *className = @"Address";
        if ([jsonFile containsString:@"recipe"]) {
            className = @"Recipe";
        }
        
        id newObject = [mapper
                        objectGraphForDownloadedJSONResourcePath:jsonFilePath
                                               withRootClassName:className];
        
        
        
        XCTAssert(newObject != nil);
    }
}


- (void)testCorrectData {
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *jsonFilePath = [bundle pathForResource:self.jsonFiles[0] ofType:@"json"];
    
    TBRJSONMapper *mapper = [[TBRJSONMapper alloc] init];
    
    Address *newAddress = [mapper
                    objectGraphForDownloadedJSONResourcePath:jsonFilePath
                    withRootClassName:@"Address"];
    

    XCTAssert(newAddress != nil);
    XCTAssert([newAddress.name isEqualToString:@"John Doe"]);
    XCTAssert([newAddress.username isEqualToString:@"john_doe"]);
    XCTAssert([newAddress.email isEqualToString:@"john@doeind.com"]);
    XCTAssert(![newAddress.partTime boolValue]);
    
    for (Phone *phone in newAddress.phones) {
        
        XCTAssert([phone.type isEqualToString:@"office"] ||
                  [phone.type isEqualToString:@"mobile"] ||
                  [phone.type isEqualToString:@"home"]);
    }
}

- (void)testOneToMany {
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *jsonFilePath = [bundle pathForResource:self.jsonFiles[1] ofType:@"json"];
    
    TBRJSONMapper *mapper = [[TBRJSONMapper alloc] init];
    
}

- (void)testOneToOne {
    
}



- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
