//
//  DVMCard.m
//  DeckOfOneCardObjC
//
//  Created by XMS_JZhan on 2/12/19.
//  Copyright © 2019 XMS_JZhan. All rights reserved.
//

#import "DVMCard.h"

@implementation DVMCard

- (instancetype)initWithSuite:(NSString *)suit image:(NSString *)image
{
    self = [super init];
    if (self) {
        _suit = suit;
        _image = image;
    }
    return self;
}

@end

@implementation DVMCard (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString *suit = dictionary[[DVMCard suitKey]];
    NSString *images = dictionary[[DVMCard imageKey]];

    return [self initWithSuite:suit image:images];
}

+ (NSString *)suitKey
{
    return @"suit";
}

+ (NSString *)imageKey
{
    return @"image";
}

@end
