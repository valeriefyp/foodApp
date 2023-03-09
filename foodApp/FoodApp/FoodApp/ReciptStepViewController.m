//
//  ReciptStepViewController.m
//  FoodApp
//
//  Created by Wai Sze Valerie Ng on 9/3/2023.
//


#import <Foundation/Foundation.h>
#import "ReciptStepViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "FoodInfoString.h"
@interface ReciptStepViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btnClose;

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;

@property (weak, nonatomic) IBOutlet UITableView *tbStep;
@property  FoodInfoString *foodstring;

@end
@implementation ReciptStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _foodstring = [[FoodInfoString alloc] init];
    
    [self initialView];
    [_tbStep registerNib:[UINib nibWithNibName:@"ReciptStepCellView" bundle:nil] forCellReuseIdentifier:@"ReciptStepCellView"];
}
- (IBAction)closeBusRouteViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)initialView{
    [_lbTitle setText:_foodstring.foodStepText];
    _tbStep.delegate = self;
    _tbStep.dataSource = self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_finalStep count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReciptStepCellView *cell =[tableView dequeueReusableCellWithIdentifier:@"ReciptStepCellView"];
    

    // Set up the cell...
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}
- (void)configureCell:(ReciptStepCellView *)cell atIndexPath:(NSIndexPath *)indexPath {
    //pdate cellForRowAtIndexPath like the following
    NSDictionary *step = [_finalStep objectAtIndex:indexPath.row];
    NSString *number = [[step objectForKey:@"number"]stringValue];
    NSString *detail = [step objectForKey:@"step"] ;

    [cell initCellData:(NSString *)number stepDetail:detail];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
@end
