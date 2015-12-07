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

- (void)testFailIfIncorrectFilename {
    
}

- (void)testCorrectData {
    
}

- (void)testOneToMany {
    
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
