@import XCTest;

#import "NSString+HYPRelationshipParser.h"

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)testParseRelationship
{
    NSString *testString = @"name";
    NSDictionary *resultDict = @{@"attribute": @"name"};

    XCTAssertEqualObjects(resultDict, [testString hyp_parseRelationship]);

    testString = @"source";
    resultDict = @{@"attribute": @"source"};

    XCTAssertEqualObjects(resultDict, [testString hyp_parseRelationship]);
}

- (void)testParseToManyRelationship
{
    NSString *testString = @"relatives[0].name";

    NSDictionary *evaluatedDict = @{@"relationship" : @"relatives",
                                 @"id": @"0",
                                 @"to_many" : @YES,
                                 @"attribute": @"name"};

    NSDictionary *resultDict = [testString hyp_parseRelationship];

    XCTAssertNotNil(resultDict);
    XCTAssertEqualObjects([resultDict valueForKey:@"relationship"], @"relatives");
    XCTAssertEqualObjects([resultDict valueForKey:@"id"], @"0");
    XCTAssertEqualObjects([resultDict valueForKey:@"to_many"], @YES);
    XCTAssertEqualObjects([resultDict valueForKey:@"attribute"], @"name");

    testString = @"relatives[1].email";

    evaluatedDict = @{@"relationship" : @"relatives",
                   @"id": @"1",
                   @"to_many" : @YES,
                   @"attribute": @"email"};

    resultDict = [testString hyp_parseRelationship];

    XCTAssertNotNil(resultDict);
    XCTAssertEqualObjects([resultDict valueForKey:@"relationship"], @"relatives");
    XCTAssertEqualObjects([resultDict valueForKey:@"id"], @"1");
    XCTAssertEqualObjects([resultDict valueForKey:@"to_many"], @YES);
    XCTAssertEqualObjects([resultDict valueForKey:@"attribute"], @"email");
}

- (void)testParseToOneRelationship
{
    NSString *testString = @"contract.name";

    NSDictionary *evaluatedDict = @{@"relationship" : @"contract",
                                 @"to_many" : @NO,
                                 @"attribute" : @"name"};

    NSDictionary *resultDict = [testString hyp_parseRelationship];

    XCTAssertNotNil(resultDict);
    XCTAssertEqualObjects([resultDict valueForKey:@"relationship"], @"contract");
    XCTAssertEqualObjects([resultDict valueForKey:@"to_many"], @NO);
    XCTAssertEqualObjects([resultDict valueForKey:@"attribute"], @"name");

    testString = @"company.email";

    evaluatedDict = @{@"relationship" : @"company",
                   @"to_many" : @NO,
                   @"attribute" : @"email"};

    resultDict = [testString hyp_parseRelationship];

    XCTAssertNotNil(resultDict);
    XCTAssertEqualObjects([resultDict valueForKey:@"relationship"], @"company");
    XCTAssertEqualObjects([resultDict valueForKey:@"to_many"], @NO);
    XCTAssertEqualObjects([resultDict valueForKey:@"attribute"], @"email");
}

@end
