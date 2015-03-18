#import "HYPParsedRelationship.h"

@implementation HYPParsedRelationship

- (BOOL)isEqual:(HYPParsedRelationship *)object
{
    return ((!self.relationship || [self.relationship isEqualToString:object.relationship]) &&
            self.index == object.index &&
            self.toMany == object.toMany &&
            (!self.attribute || [self.attribute isEqualToString:object.attribute]));
}

@end
