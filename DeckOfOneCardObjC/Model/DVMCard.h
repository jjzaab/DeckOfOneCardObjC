//
//  DVMCard.h
//  DeckOfOneCardObjC
//
//  Created by XMS_JZhan on 2/12/19.
//  Copyright © 2019 XMS_JZhan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DVMCard : NSObject

@property (nonatomic, readonly, copy) NSString *suit;
@property (nonatomic, readonly, copy) NSString *image;

- (instancetype) initWithSuite:(NSString *)suit image:(NSString *)image;

@end

@interface DVMCard (JSONConvertable)

- (instancetype) initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
