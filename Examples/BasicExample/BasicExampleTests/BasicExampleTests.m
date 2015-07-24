//
//  BasicExampleTests.m
//  BasicExampleTests
//
//  Created by Nahuel Marisi on 2015-07-21.
//  Copyright (c) 2015 TechBrewers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "TBRJSONMapper.h"

@interface BasicExampleTests : XCTestCase

@property (strong, nonatomic) NSArray *jsonFiles;
@end

@implementation BasicExampleTests

- (void)setUp {
    [super setUp];
    
    self.jsonFiles = @[@"address"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
    
    for (NSString *jsonFile in self.jsonFiles) {

        TBRJSONMapper *mapper = [[TBRJSONMapper alloc] init];
        
        id newObject = [mapper objectGraphForJSONResource:jsonFile
                                        withRootClassName:jsonFile.capitalizedString];

        XCTAssert(newObject != nil);
        
    }

 
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
