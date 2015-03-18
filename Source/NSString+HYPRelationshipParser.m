#import "NSString+HYPRelationshipParser.h"

#import "HYPParsedRelationship.h"

@implementation NSString (HYPRelationshipParser)

- (HYPParsedRelationship *)hyp_parseRelationship
{
    HYPParsedRelationship *parsedRelationship;

    NSMutableCharacterSet *alphanumericSet = [NSMutableCharacterSet alphanumericCharacterSet];
    [alphanumericSet addCharactersInString:@"_"];

    BOOL valid = [[self stringByTrimmingCharactersInSet:alphanumericSet] isEqualToString:@""];

    if (valid) {
        parsedRelationship = [HYPParsedRelationship new];
        parsedRelationship.attribute = self;
    } else {
        NSCharacterSet *toManySet = [NSCharacterSet characterSetWithCharactersInString:@"[]"];
        NSRange toManyRange = [self rangeOfCharacterFromSet:toManySet];
        BOOL isToManyRelationship = (toManyRange.location != NSNotFound);

        NSString *relationship, *attribute;
        NSNumber *index;
        BOOL toMany, faulty;

        if (isToManyRelationship) {
            toMany = YES;

            NSScanner *scanner = [NSScanner scannerWithString:self];
            if ([scanner scanUpToString:@"[" intoString:&relationship]) {
                if (scanner.isAtEnd) {
                    faulty = YES;
                } else {
                    scanner.scanLocation++;

                    NSString *indexString;
                    if ([scanner scanUpToString:@"]" intoString:&indexString]) {
                        index = @([indexString integerValue]);
                        scanner.scanLocation++;

                        if (!scanner.isAtEnd) {
                            scanner.scanLocation++;
                            [scanner scanUpToString:@"\n" intoString:&attribute];
                        }
                    }
                }
            } else {
                faulty = YES;
            }
        } else {
            NSArray *elements = [self componentsSeparatedByString:@"."];
            BOOL isValidToOneRelationship = (elements.count == 2 &&
                                             [elements.firstObject length] > 0 &&
                                             [elements.lastObject length] > 0);
            if (isValidToOneRelationship) {
                relationship = [elements firstObject];
                attribute = [elements lastObject];
            } else {
                faulty = YES;
            }
        }

        if (!faulty) {
            parsedRelationship = [HYPParsedRelationship new];
            parsedRelationship.relationship = relationship;
            parsedRelationship.index = index;
            parsedRelationship.toMany = toMany;
            parsedRelationship.attribute = attribute;
        }
    }

    return parsedRelationship;
}

- (NSString *)hyp_updateRelationshipIndex:(NSInteger)index
{
    HYPParsedRelationship *parsedRelationship = [self hyp_parseRelationship];

    return [NSString stringWithFormat:@"%@[%@].%@", parsedRelationship.relationship, @(index), parsedRelationship.attribute];
}

@end
