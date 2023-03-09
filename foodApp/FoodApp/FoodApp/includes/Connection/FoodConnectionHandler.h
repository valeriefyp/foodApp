//
//  FoodConnectionHandler.h
//  FoodApp
//
//  Created by Valerie Ng on 15/2/2023.
//
#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "GlobalConstant.h"

@class FoodConnectionHandler;
@protocol FoodConnectionDelegate <NSObject>

@optional
- (void)FoodConnectionHandler:(FoodConnectionHandler *)handler didFinishTargetFood:(BOOL)success fooddetail:(NSDictionary *)foodDetailInfo foodRecipe:(NSMutableArray *)RecipeList;
- (void)FoodConnectionHandler:(FoodConnectionHandler *)handler didFinishRecipeDetail:(BOOL)success foodRecipe:(NSArray *)foodRecipe;
//- (void)BusConnectionHandler:(BusConnectionHandler *)handler didFinishGetAllCTBRoute:(BOOL)success;
//- (void)BusConnectionHandler:(BusConnectionHandler *)handler didFinishGetAllNWFBRoute:(BOOL)success;
//- (void)BusConnectionHandler:(BusConnectionHandler *)handler didFinishGetAllBusRoute:(NSMutableArray *)mBusRouteInformation;

@end
@interface FoodConnectionHandler : NSObject

@property (nonatomic, weak) id <FoodConnectionDelegate> delegate;

- (void)getTargetFoodNutrition:(NSString *)mTargetFood;
- (void)getRecipeDetail:(NSString *)mTargetFood;


@end
