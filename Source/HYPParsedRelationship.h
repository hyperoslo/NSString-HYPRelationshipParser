@import Foundation;

@interface HYPParsedRelationship : NSObject

@property (nonatomic) NSString *relationship;
@property (nonatomic) NSInteger index;
@property (nonatomic) BOOL toMany;
@property (nonatomic) NSString *attribute;

- (NSString *)key;

@end
