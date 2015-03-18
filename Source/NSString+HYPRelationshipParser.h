@import Foundation;

@class HYPParsedRelationship;

@interface NSString (HYPRelationshipParser)

- (HYPParsedRelationship *)hyp_parseRelationship;

@end
