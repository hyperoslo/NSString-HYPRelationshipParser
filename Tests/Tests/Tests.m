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

    testString = @"source_id";
    resultDict = @{@"attribute": @"source_id"};

    XCTAssertEqualObjects(resultDict, [testString hyp_parseRelationship]);
}

- (void)testParseToManyRelationship
{
    NSString *testString = @"relatives[0].first_name";

    NSDictionary *evaluatedDict = @{@"relationship" : @"relatives",
                                    @"index": @0,
                                    @"to_many" : @YES,
                                    @"attribute": @"first_name"};

    NSDictionary *resultDict = [testString hyp_parseRelationship];

    XCTAssertNotNil(resultDict);
    XCTAssertEqualObjects([resultDict valueForKey:@"relationship"], @"relatives");
    XCTAssertEqualObjects([resultDict valueForKey:@"index"], @0);
    XCTAssertEqualObjects([resultDict valueForKey:@"to_many"], @YES);
    XCTAssertEqualObjects([resultDict valueForKey:@"attribute"], @"first_name");

    testString = @"relatives[1].email";

    evaluatedDict = @{@"relationship" : @"relatives",
                      @"index": @1,
                      @"to_many" : @YES,
                      @"attribute": @"email"};

    resultDict = [testString hyp_parseRelationship];

    XCTAssertNotNil(resultDict);
    XCTAssertEqualObjects([resultDict valueForKey:@"relationship"], @"relatives");
    XCTAssertEqualObjects([resultDict valueForKey:@"index"], @1);
    XCTAssertEqualObjects([resultDict valueForKey:@"to_many"], @YES);
    XCTAssertEqualObjects([resultDict valueForKey:@"attribute"], @"email");
}

- (void)testParseToOneRelationship
{
    NSString *testString = @"contract.first_name";

    NSDictionary *evaluatedDict = @{@"relationship" : @"contract",
                                    @"to_many" : @NO,
                                    @"attribute" : @"first_name"};

    NSDictionary *resultDict = [testString hyp_parseRelationship];

    XCTAssertNotNil(resultDict);
    XCTAssertEqualObjects([resultDict valueForKey:@"relationship"], @"contract");
    XCTAssertEqualObjects([resultDict valueForKey:@"to_many"], @NO);
    XCTAssertEqualObjects([resultDict valueForKey:@"attribute"], @"first_name");

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

- (void)testFaultyStrings
{
    XCTAssertNil([@"relatives0].name" hyp_parseRelationship]);
    XCTAssertNil([@"relatives0]].name" hyp_parseRelationship]);
    XCTAssertNil([@"[relatives.name" hyp_parseRelationship]);
    XCTAssertNil([@"relatives." hyp_parseRelationship]);
}

@end
