//
//  DVMCardController.m
//  DeckOfOneCardObjC
//
//  Created by XMS_JZhan on 2/12/19.
//  Copyright © 2019 XMS_JZhan. All rights reserved.
//

#import "DVMCardController.h"

static NSString * const baseURL = @"https://deckofcardsapi.com/api/deck/new/draw/";

@implementation DVMCardController

+ (DVMCardController *)shared
{
    static DVMCardController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [DVMCardController new];
    });
    return shared;
}

+ (NSURL *)urlWithString:(NSString *)url
{
    return [[NSURL alloc] initWithString:url];
}

- (void)drawNewCard:(NSInteger)numberOfCards
          completion:(void (^)(NSArray<DVMCard *> *_Nullable, NSError * _Nullable))completion
{
    NSString *cardCount = [@(numberOfCards) stringValue];
    NSURL *url = [[NSURL alloc] initWithString:baseURL];
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:YES];
    
    NSURLQueryItem *query = [[NSURLQueryItem alloc] initWithName:@"count" value: cardCount];
    [components setQueryItems:@[query]];
    
    NSURL *finalURL = [components URL];
    
    [[NSURLSession.sharedSession dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil, nil);
            return;
        }
        
        if (response) {
            NSLog(@"%@", response);
        }
        
        if (data) {
            NSDictionary *jsonDictionaries = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if (!jsonDictionaries || ![jsonDictionaries isKindOfClass:[NSDictionary class]]) {
                NSLog(@"Error parsing JSON %@", error);
                completion(nil, nil);
                return;
            }
            NSArray *cardsArray = jsonDictionaries[@"cards"];
            
            NSMutableArray *cardsPlaceholder = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in cardsArray) {
                DVMCard *card = [[DVMCard alloc] initWithDictionary:dict];
                [cardsPlaceholder addObject:card];
            }
            
            completion(cardsPlaceholder, nil);
        }
    }] resume];
}

- (void)fetchCardImage:(DVMCard *)card completion:(void (^)(UIImage * _Nullable, NSError * _Nullable))completion
{
    NSURL *imageURL = [[NSURL alloc] initWithString:card.image];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil, nil);
            return;
        }
        
        if (response) {
            NSLog(@"%@", response);
        }
        
        if (data) {
            UIImage *cardImage = [[UIImage alloc] initWithData:data];
            completion(cardImage, nil);
        }
    }] resume];
}
    
@end
