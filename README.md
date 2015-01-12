# NSString-HYPRelationshipParser

[![CI Status](http://img.shields.io/travis/hyperoslo/NSString-HYPRelationshipParser.svg?style=flat)](https://travis-ci.org/hyperoslo/NSString-HYPRelationshipParser)
[![Version](https://img.shields.io/cocoapods/v/NSString-HYPRelationshipParser.svg?style=flat)](http://cocoadocs.org/docsets/NSString-HYPRelationshipParser)
[![License](https://img.shields.io/cocoapods/l/NSString-HYPRelationshipParser.svg?style=flat)](http://cocoadocs.org/docsets/NSString-HYPRelationshipParser)
[![Platform](https://img.shields.io/cocoapods/p/NSString-HYPRelationshipParser.svg?style=flat)](http://cocoadocs.org/docsets/NSString-HYPRelationshipParser)

## Usage

```objc
- (NSDictionary *)hyp_parseRelationship;
```

## Example

```objc
NSDictionary *resultDict = [@"name" hyp_parseRelationship];
/*
{
    @"attribute": @"name"
};
*/

NSDictionary *resultDict = [@"company.name" hyp_parseRelationship];
/*
{
    @"relationship" : @"company",
    @"to_many" : @NO,
    @"attribute": @"name"
};
*/

NSDictionary *resultDict = [@"employees[0].email" hyp_parseRelationship];
/*
{
    @"relationship" : @"employees",
    @"index": @0,
    @"to_many" : @YES,
    @"attribute": @"email"
};
*/
```

## Installation

**NSString-HYPRelationshipParser** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

`pod 'NSString-HYPRelationshipParser'`

## Author

Hyper AS, teknologi@hyper.no

## License

**NSString-HYPRelationshipParser** is available under the MIT license. See the LICENSE file for more info.
