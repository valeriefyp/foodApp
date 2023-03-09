//
//  ViewController.m
//  FoodApp
//
//  Created by Valerie Ng on 15/2/2023.
//

#import "ViewController.h"
#import "FoodConnectionHandler.h"
#import "FoodInfoString.h"
#import <QuartzCore/QuartzCore.h>
#import "ReciptStepViewController.h"
#import "ReciptStepNavigationController.h"
#import "foodPie.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // stop loading spinner at beginning
    [_loadingProgressView stopAnimating];
    FoodInfoString *foodInfoString = [[FoodInfoString alloc] init];
    [_tbFoodDetail registerNib:[UINib nibWithNibName:@"FoodNutritionTableCellView" bundle:nil] forCellReuseIdentifier:@"FoodNutritionTableCellView"];
    _tfsearch.layer.cornerRadius = 10.0;
    _nutritionTitle.hidden = YES;
    _imgRecipe.hidden= YES;

    //                //not full screen?
//    _ReciptStepNavigationController.modalPresentationStyle = UIModalPresentationFullScreen;
    _embeddedVC = [self.storyboard instantiateViewControllerWithIdentifier:@"foodPie"];
    [self addChildViewController:_embeddedVC];
    [self.containerView addSubview:_embeddedVC.view];
    [self.containerView setHidden:YES];
    _tfsearch.clipsToBounds = true;
    [_lbsearchTitle setText:foodInfoString.foodTitleText];
    _tfsearch.placeholder = foodInfoString.foodSearchText;
    // Do any additional setup after loading the view.
    _mFoodConnectionHandler = [[FoodConnectionHandler alloc] init];
    _mFoodConnectionHandler.delegate = self;
    _tbFoodDetail.delegate = self;
    _tbFoodDetail.dataSource = self;
    [_tbFoodDetail setHidden:YES];
    [_imgEmpty setHidden:NO];
    // Create a tap gesture recognizer and add it to the icInfo image view
    UITapGestureRecognizer *InfotapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleInfoTapGesture:)];
    
    self.icInfo.userInteractionEnabled = YES;

    [self.icInfo addGestureRecognizer:InfotapGesture];
    
    UITapGestureRecognizer *foodDetailtapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFoodNutrition:)];
    self.imgFood.userInteractionEnabled = YES;
    [self.imgFood addGestureRecognizer:foodDetailtapGesture];
    
    UITapGestureRecognizer *recipetapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showRecipe:)];
    self.imgRecipe.userInteractionEnabled = YES;
    [self.imgRecipe addGestureRecognizer:recipetapGesture];

}
- (void)showFoodNutrition:(UITapGestureRecognizer *)tapGesture {
    // show food detail
    self->_tbFoodDetail.hidden = YES;
    self->_embeddedVC.view.hidden = NO;
}

- (void)showRecipe:(UITapGestureRecognizer *)tapGesture {
    // show food detail
    self->_tbFoodDetail.hidden = NO;
    [_tbFoodDetail reloadData];
    self->_embeddedVC.view.hidden = YES;


}

- (void)handleInfoTapGesture:(UITapGestureRecognizer *)tapGesture {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Remind U" message:@"Nutrition data for each food item is scaled to 100g." preferredStyle:UIAlertControllerStyleAlert];
     UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
     [alert addAction:okAction];
     [self presentViewController:alert animated:YES completion:nil];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"foodPie"]) {
        // Get a reference to the destination view controller
        foodPie *destinationVC = segue.destinationViewController;
        destinationVC.FoodKey =_FoodKey ;
        destinationVC.FoodValue =_FoodValue ;
        
        // Pass any necessary data to the destination view controller
    }
}
- (IBAction)searchClick:(id)sender {
    _targetFood = _tfsearch.text;
    // set loading spinner and delegate will start method
    [self.loadingProgressView startAnimating];
    _nutritionTitle.hidden = NO;
    _nutritionTitle.text = [_tfsearch.text uppercaseString];
    _tbFoodDetail.hidden = YES;
    self->_embeddedVC.view.hidden = YES;
   

    if(_targetFood.length > 0)
    {
        [_mFoodConnectionHandler getTargetFoodNutrition:_targetFood];
    }

}
#pragma mark - FoodConnectionHandlerDelegate
-(void)FoodConnectionHandler:(FoodConnectionHandler *)handler didFinishRecipeDetail:(BOOL)success foodRecipe:(NSMutableArray *)foodRecipe{
    
    if(success)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ReciptStepViewController" bundle:nil];
_ReciptStepNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"ReciptStepNavigationController"];
_mReciptStepViewController = _ReciptStepNavigationController.childViewControllers[0];
        _mReciptStepViewController.finalStep = foodRecipe;

        
        [self showDialog];
        

    }else{
        //no detail
    }
}
    
-(void)showDialog{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:self->_ReciptStepNavigationController animated:YES completion:nil];
    });

}
- (void)FoodConnectionHandler:(FoodConnectionHandler *)handler didFinishTargetFood:(BOOL)success fooddetail:(NSDictionary *)mfoodDetailInfo foodRecipe:(NSMutableArray *)RecipeList{

    if (success) {
        if(mfoodDetailInfo.count>0)
        {
            
            mfoodDetailInfo = mfoodDetailInfo;
            _FoodKey = [mfoodDetailInfo allKeys];
            _FoodValue = [mfoodDetailInfo allValues];
            _RecipeList = [[NSMutableArray alloc]init];
            _RecipeList = RecipeList;
         
            dispatch_async(dispatch_get_main_queue(), ^{
                _embeddedVC.view.hidden = NO;
                [self.loadingProgressView stopAnimating];
                if(self->_RecipeList.count > 0)
                {
                    [self->_tbFoodDetail reloadData];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        // Code to execute after delay
                        
                        self->_imgRecipe.hidden= NO;


                    });

                }else{
                    self->_imgRecipe.hidden= YES;
                }
//                [self->_tbFoodDetail reloadData];
//                [self->_tbFoodDetail setHidden:NO];
//                [self -> _imgEmpty setHidden:YES];
                   [self.containerView setHidden:NO];
                self->_embeddedVC.FoodKey =self->_FoodKey;
                self->_embeddedVC.FoodValue =self->_FoodValue;
                [self->_embeddedVC initWithChartType];
           
            });
            
            
        }
    }else{
        //fail
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.loadingProgressView stopAnimating];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sorry" message:@"We do not have this Nutrition data. Please check the internet and try again" preferredStyle:UIAlertControllerStyleAlert];
             UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
             [alert addAction:okAction];
             [self presentViewController:alert animated:YES completion:nil];
    });
       
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
        FoodNutritionTableCellView *cell =[tableView dequeueReusableCellWithIdentifier:@"FoodNutritionTableCellView"];
        [self configureCell:cell atIndexPath:indexPath];
        return cell;
        
        
        // Set up the cell...
    }
    - (void)configureCell:(FoodNutritionTableCellView *)cell atIndexPath:(NSIndexPath *)indexPath {
     
        //pdate cellForRowAtIndexPath like the following
            NSDictionary *targetRecipeDetail = [_RecipeList objectAtIndex:indexPath.row];
        NSString *mRecipeTitle =  [targetRecipeDetail objectForKey:@"title"];
        NSString *mRecipeURL =  [targetRecipeDetail objectForKey:@"image"];
        [cell initCellData:mRecipeTitle ReciptImage:mRecipeURL];
    }
    
#pragma mark - UITableViewDelegate
    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return UITableViewAutomaticDimension;
    }
#pragma mark - UITableViewDataSource
    - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
        return 0;
    }
    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return [_FoodKey count];
    }
    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        NSLog(@"%lu", (unsigned long)indexPath.row);

        NSDictionary *targetRecipeDetail = [_RecipeList objectAtIndex:indexPath.row];
        NSString *mRecipeId =  [targetRecipeDetail objectForKey:@"id"];
        [_mFoodConnectionHandler getRecipeDetail:mRecipeId];
      
    }

@end
