//
//  ReciptStepCellView.h
//  FoodApp
//
//  Created by Wai Sze Valerie Ng on 9/3/2023.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ReciptStepCellView : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lbDetail;

@property (strong, nonatomic) IBOutlet UILabel *lbStep;
- (void)initCellData:(NSString*)step stepDetail:(NSString*)stepDetail;
@end
