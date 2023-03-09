//
//  ViewController.h
//  FoodApp
//
//  Created by Valerie Ng on 15/2/2023.
//

#import <UIKit/UIKit.h>
#import "FoodConnectionHandler.h"
#import "FoodNutritionTableCellView.h"
#import "ReciptStepViewController.h"
#import "foodPie.h"
#import "ReciptStepNavigationController.h"

@interface ViewController : UIViewController<FoodConnectionDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *icInfo;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingProgressView;

@property (strong, nonatomic) IBOutlet UIImageView *imgEmpty;
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *lbsearchTitle;
@property (weak, nonatomic) IBOutlet UITextField *tfsearch;
@property (weak, nonatomic) IBOutlet UITableView *tbFoodDetail;
@property NSDictionary *finalTargetFood;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
@property (strong, nonatomic) IBOutlet UILabel *nutritionTitle;
@property (strong, nonatomic) IBOutlet UIImageView *imgFood;
@property (strong, nonatomic) IBOutlet UIImageView *imgRecipe;
@property (strong, nonatomic) IBOutlet NSMutableArray *RecipeList;
@property (strong, nonatomic)  FoodConnectionHandler *mFoodConnectionHandler;
@property NSString *targetFood;
@property (strong, nonatomic) NSArray *FoodKey;
@property (strong, nonatomic) NSArray *FoodValue;
@property (strong, nonatomic) foodPie *embeddedVC;
@property (strong, nonatomic) ReciptStepNavigationController *ReciptStepNavigationController;
@property (strong, nonatomic)  ReciptStepViewController *mReciptStepViewController;

@end
