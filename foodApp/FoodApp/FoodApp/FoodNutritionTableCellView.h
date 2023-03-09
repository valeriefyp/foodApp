//
//  FoodNutritionTableCellView.h
//  FoodApp
//
//  Created by Valerie Ng on 15/2/2023.
//

#import "FoodInfoString.h"
#import <UIKit/UIKit.h>
@interface FoodNutritionTableCellView : UITableViewCell


@property (strong, nonatomic) FoodInfoString *foodInfoString;
@property (weak, nonatomic) IBOutlet UILabel *lbItemTitle;
@property (weak, nonatomic) IBOutlet UIImageView *lbItemImage;

- (void)initCellData:(NSString *)mRecipeTitle ReciptImage:mRecipeURL;
@end

