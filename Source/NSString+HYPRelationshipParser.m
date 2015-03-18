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
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"[]."];
        NSRange range = [self rangeOfCharacterFromSet:set];
        BOOL isRelationship = (range.location != NSNotFound);

        if (isRelationship) {
            NSCharacterSet *toManySet = [NSCharacterSet characterSetWithCharactersInString:@"[]"];
            NSRange toManyRange = [self rangeOfCharacterFromSet:toManySet];
            BOOL isToManyRelationship = (toManyRange.location != NSNotFound);

            if (isToManyRelationship) {
                NSScanner *scanner = [NSScanner scannerWithString:self];
                NSString *relationship;

                if ([scanner scanUpToString:@"[" intoString:&relationship]) {

                    if (!scanner.isAtEnd) {
                        scanner.scanLocation++;

                        NSString *objectID;
                        if ([scanner scanUpToString:@"]" intoString:&objectID]) {
                            scanner.scanLocation += 2;

                            NSString *name;
                            if ([scanner scanUpToString:@"\n" intoString:&name]) {
                                if (relationship && objectID && name) {
                                    parsedRelationship = [HYPParsedRelationship new];
                                    parsedRelationship.relationship = relationship;
                                    parsedRelationship.index = [objectID integerValue];
                                    parsedRelationship.toMany = YES;
                                    parsedRelationship.attribute = name;
                                }
                            }
                        }
                    }
                }

            } else {
                NSArray *elements = [self componentsSeparatedByString:@"."];
                BOOL isValidToOneRelationship = (elements.count == 2 &&
                                                 [elements.firstObject length] > 0 &&
                                                 [elements.lastObject length] > 0);
                if (isValidToOneRelationship) {
                    parsedRelationship = [HYPParsedRelationship new];
                    parsedRelationship.relationship = [elements firstObject];
                    parsedRelationship.toMany = NO;
                    parsedRelationship.attribute = [elements lastObject];
                }
            }
        }
    }

    return parsedRelationship;
}

- (NSString *)hyp_updateRelationshipIndex:(NSInteger)index
{
    return nil;
}

@end
