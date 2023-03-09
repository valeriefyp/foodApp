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

- (void)initCellData:(NSString *)mRecipeTitle ReciptImage:(NSString *)mRecipeURL{
    [_lbItemTitle setText:mRecipeTitle];
//    mRecipeURL
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSURL *url = [NSURL URLWithString:mRecipeURL];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.lbItemImage setImage:image];
        });
    });
    [self layoutIfNeeded];
}
@end

