//
//  foodPie.h
//  FoodApp
//
//  Created by Wai Sze Valerie Ng on 2/3/2023.
//


#import <UIKit/UIKit.h>
#import "PieChart.h"

@class foodPie;

typedef enum{
    ChartTypePie
}ChartType;

@interface foodPie : UIViewController
@property (strong, nonatomic) IBOutlet UIView *subview;
@property (nonatomic)  PieChart *chart;
@property (nonatomic) ChartType chartType;
@property (strong, nonatomic) NSArray *FoodKey;
@property (strong, nonatomic) NSArray *FoodValue;
- (instancetype)initWithChartType;

@end
