//
//  DVMCardViewController.m
//  DeckOfOneCardObjC
//
//  Created by XMS_JZhan on 2/12/19.
//  Copyright © 2019 XMS_JZhan. All rights reserved.
//

#import "DVMCardViewController.h"
#import "DVMCardController.h"

@interface DVMCardViewController ()

@property (weak, nonatomic) IBOutlet UILabel *suitLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;

@end

@implementation DVMCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)updateViews
{
    [[DVMCardController shared] drawNewCard:1 completion:^(NSArray<DVMCard *> * _Nonnull cards, NSError * _Nonnull error) {
        DVMCard *card = [cards objectAtIndex:0];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.suitLabel.text = cards[0].suit;
        });
        
        [[DVMCardController shared] fetchCardImage:card completion:^(UIImage * _Nonnull image, NSError * _Nonnull error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.cardImageView.image = image;
            });
            
        }];
    }];
}

- (IBAction)drawCardButtonTapped:(UIButton *)sender
{
    [self updateViews];
}

@end
