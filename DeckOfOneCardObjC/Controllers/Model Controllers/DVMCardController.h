//
//  DVMCardController.h
//  DeckOfOneCardObjC
//
//  Created by XMS_JZhan on 2/12/19.
//  Copyright © 2019 XMS_JZhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DVMCard.h"

NS_ASSUME_NONNULL_BEGIN

@interface DVMCardController : NSObject

+ (DVMCardController *)shared;

+ (NSString *)urlWithString:(NSURL *)url;

- (void)drawNewCard:(NSInteger)numberOfCards
          completion:(void(^) (NSArray<DVMCard *> *cards, NSError *error))completion;

- (void)fetchCardImage:(DVMCard *)card
            completion:(void(^) (UIImage *image, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
