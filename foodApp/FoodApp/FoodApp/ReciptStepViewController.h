//
//  ReciptStepViewController.h
//  FoodApp
//
//  Created by Wai Sze Valerie Ng on 9/3/2023.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ReciptStepCellView.h"
@interface ReciptStepViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property NSMutableArray *finalStep;
@end


