//
//  FoodNutritionTableCellView.m
//  FoodApp
//
//  Created by Valerie Ng on 15/2/2023.
//

#import <Foundation/Foundation.h>
#import "FoodNutritionTableCellView.h"
#import "FoodInfoString.h"
#import "UIColor.h"

@implementation FoodNutritionTableCellView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _foodInfoString = [[FoodInfoString alloc] init];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)initCellData:(NSString *)mFoodDetail FoodDetailNum:(NSNumber *)mFoodDetailNum{
    [_lbFoodInfoName setText:mFoodDetail];
    NSString *szFoodDetailNum = [mFoodDetailNum stringValue];
    szFoodDetailNum = [NSString stringWithFormat:@"%@%@", szFoodDetailNum, @"g"];
    [_lbItemDetail setText:szFoodDetailNum];
    float percentage = 0.f ;
    double value  = [szFoodDetailNum doubleValue];
//    percentage = (float) value/100;
//    _linebar.trackTintColor = [UIColor whiteColor];
//    _linebar.progress = percentage;
//    _linebar.progressTintColor =[UIColor colorProgressOrange];
    [self layoutIfNeeded];
}
@end

