//
//  foodPie.m
//  FoodApp
//
//  Created by Wai Sze Valerie Ng on 2/3/2023.
//

#import <Foundation/Foundation.h>
#import "foodPie.h"
#import "LegendView.h"
#import "PieChart.h"
#import "Constants.h"

#define header_height 0
@interface foodPie ()<PieChartDataSource, PieChartDelegate>

@end

@implementation foodPie
- (instancetype)initWithChartType{
    self = [super init];
    if (self) {
        [self createView];
    
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   

    [self.view setBackgroundColor:[UIColor whiteColor]];

}
-(void)viewWillAppear:(BOOL)animated{
    if(_FoodKey.count>0)
    {
        [self createView];
//        _FoodKey = @[@"A",@"B",@"C"];
//        _FoodValue =[NSArray arrayWithObjects:@1,@2,@3, nil];
    }
}
- (void)createView{
    [self createGraph];
}

//- (void)createHeader{
//    [self.navigationItem setTitle:@"Charts"];
//}


- (void) createGraph{
    [self createPieChart];
}
#pragma Mark CreatePieChart
- (void)createPieChart{
    PieChart *chart = [[PieChart alloc] initWithFrame:CGRectMake(0, header_height, WIDTH(self.view), (HEIGHT(self.view) - header_height)/2)];
    [chart setDataSource:self];
    [chart setDelegate:self];
    [chart setLegendViewType:LegendTypeHorizontal];
    [chart setShowCustomMarkerView:TRUE];
    [chart drawPieChart];
    [self.view addSubview:chart];
}

#pragma mark PieChartDataSource
- (NSInteger)numberOfValuesForPieChart{
    return _FoodKey.count;
}

- (UIColor *)colorForValueInPieChartWithIndex:(NSInteger)lineNumber{
    NSInteger aRedValue = arc4random()%255;
    NSInteger aGreenValue = arc4random()%255;
    NSInteger aBlueValue = arc4random()%255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue/255.0f green:aGreenValue/255.0f blue:aBlueValue/255.0f alpha:1.0f];
    return randColor;
}

- (NSString *)titleForValueInPieChartWithIndex:(NSInteger)index{
    return [_FoodKey objectAtIndex:index];
}

- (NSNumber *)valueInPieChartWithIndex:(NSInteger)index{
    return [_FoodValue objectAtIndex:index];
}

- (UIView *)customViewForPieChartTouchWithValue:(NSNumber *)value{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor whiteColor]];
    [view.layer setCornerRadius:4.0F];
    [view.layer setBorderWidth:1.0F];
    [view.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [view.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [view.layer setShadowRadius:2.0F];
    [view.layer setShadowOpacity:0.3F];

    UILabel *label = [[UILabel alloc] init];
    [label setFont:[UIFont systemFontOfSize:12]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:[NSString stringWithFormat:@"%@ : %@ gram", value]];
    [label setFrame:CGRectMake(0, 0, 100, 30)];
    [view addSubview:label];
    
    [view setFrame:label.frame];
    return view;
}

#pragma mark PieChartDelegate
- (void)didTapOnPieChartWithValue:(NSString *)value{
    NSLog(@"Pie Chart: %@",value);
}

@end
