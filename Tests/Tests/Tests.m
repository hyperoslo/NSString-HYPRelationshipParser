@import XCTest;

#import "NSString+HYPRelationshipParser.h"
#import "HYPParsedRelationship.h"

@interface Tests : XCTestCase

@end

@implementation Tests

#pragma mark - Category

- (void)testParseRelationshipA
{
    HYPParsedRelationship *result = [HYPParsedRelationship new];
    result.attribute = @"name";

    XCTAssertEqualObjects(result, [@"name" hyp_parseRelationship]);
}

- (void)testParseRelationshipB
{
    HYPParsedRelationship *result = [HYPParsedRelationship new];
    result.attribute = @"source_id";

    XCTAssertEqualObjects(result, [@"source_id" hyp_parseRelationship]);
}

- (void)testParseToManyRelationshipA
{
    HYPParsedRelationship *result = [HYPParsedRelationship new];
    result.relationship = @"relatives";
    result.index = @0;
    result.toMany = YES;
    result.attribute = @"first_name";

    XCTAssertEqualObjects([@"relatives[0].first_name" hyp_parseRelationship], result);
}

- (void)testParseToManyRelationshipB
{
    HYPParsedRelationship *result = [HYPParsedRelationship new];
    result.relationship = @"relatives";
    result.index = @1;
    result.toMany = YES;
    result.attribute = @"email";

    XCTAssertEqualObjects([@"relatives[1].email" hyp_parseRelationship], result);
}

- (void)testParseToOneRelationshipA
{
    HYPParsedRelationship *result = [HYPParsedRelationship new];
    result.relationship = @"contract";
    result.toMany = NO;
    result.attribute = @"first_name";

    XCTAssertEqualObjects([@"contract.first_name" hyp_parseRelationship], result);
}

- (void)testParseToOneRelationshipB
{
    HYPParsedRelationship *result = [HYPParsedRelationship new];
    result.relationship = @"company";
    result.toMany = NO;
    result.attribute = @"email";

    XCTAssertEqualObjects([@"company.email" hyp_parseRelationship], result);
}

- (void)testFaultyStrings
{
    XCTAssertNil([@"relatives0].name" hyp_parseRelationship]);
    XCTAssertNil([@"relatives0]].name" hyp_parseRelationship]);
    XCTAssertNil([@"[relatives.name" hyp_parseRelationship]);
    XCTAssertNil([@"relatives." hyp_parseRelationship]);
}

- (void)testUpdateRelationshipIndex
{
    XCTAssertEqualObjects([@"contacts[2].first_name" hyp_updateRelationshipIndex:3], @"contacts[3].first_name");
}

#pragma mark - Model

- (void)testKeyA
{
    HYPParsedRelationship *result = [HYPParsedRelationship new];
    result.relationship = @"contacts";
    result.index = @2;
    result.attribute = @"first_name";

    XCTAssertEqualObjects([result key], @"contacts[2].first_name");
}

- (void)testKeyB
{
    HYPParsedRelationship *result = [HYPParsedRelationship new];
    result.relationship = @"contacts";
    result.index = @2;

    XCTAssertEqualObjects([result key], @"contacts[2]");
}

- (void)testKeyC
{
    HYPParsedRelationship *result = [HYPParsedRelationship new];
    result.relationship = @"company";
    result.attribute = @"name";

    XCTAssertEqualObjects([result key], @"company.name");
}

@end
