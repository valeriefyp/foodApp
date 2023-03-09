//
//  FoodNutritionTableCellView.h
//  FoodApp
//
//  Created by Valerie Ng on 15/2/2023.
//

#import "FoodInfoString.h"
#import <UIKit/UIKit.h>
@interface FoodNutritionTableCellView : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbFoodInfoName;
@property (strong, nonatomic) FoodInfoString *foodInfoString;
@property (weak, nonatomic) IBOutlet UILabel *lbItemDetail;
@property (weak, nonatomic) IBOutlet UIProgressView *linebar;


//@property (strong, nonatomic) NSString *foodInfostring;

- (void)initCellData:(NSString *)mFoodDetailType FoodDetailNum:(NSNumber *)mFoodDetailNum;
@end
