//
//  FoodInfoString.m
//  FoodApp
//
//  Created by Valerie Ng on 15/2/2023.
//

#import "FoodInfoString.h"

@interface FoodInfoString()


@end

@implementation FoodInfoString

- (id)init {
    
     _caloriesText  = @"Calories";
    _fatTotalText  = @"Total Fat";
    _fatSaturatedText  = @"Saturated Fat";
    _proteinText  = @"Protein";
    _sodiumText  = @"Sodium";
    _potassiumText  = @"Potassium";
    _cholesterolText  = @"Cholesterol";
    _carbohydratesText  = @"Carbohydrates";
    _fiberText  = @"Fiber";
    _sugarText  = @"Sugar";
    _foodTitleText = @"Food Nutrition Information";
    _foodSearchText = @"  Food Search";
    _foodStepText = @"Step";
    return self;
}

@end
