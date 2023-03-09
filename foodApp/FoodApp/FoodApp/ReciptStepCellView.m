//
//  ReciptStepCellView.m
//  FoodApp
//
//  Created by Wai Sze Valerie Ng on 9/3/2023.
//


#import <Foundation/Foundation.h>
#import "ReciptStepCellView.h"

@implementation ReciptStepCellView
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initCellData:(NSString*)step stepDetail:(NSString*)stepDetail{
    [self.lbStep setTextColor:[UIColor whiteColor]];
    self.lbStep.text = step;
    self.lbStep.textAlignment = NSTextAlignmentCenter;
    self.lbStep.backgroundColor = [UIColor colorWithRed:1.0 green:0.65 blue:0 alpha:1.0];
    self.lbStep.layer.cornerRadius = 10;
    self.lbStep.layer.masksToBounds = YES;
    self.lbDetail.text = stepDetail;
    [self layoutIfNeeded];

}

@end
