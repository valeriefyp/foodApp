//
//  FoodConnectionHandler.m
//  FoodApp
//
//  Created by Valerie Ng on 15/2/2023.
//

#import <Foundation/Foundation.h>
#import "FoodConnectionHandler.h"

@interface FoodConnectionHandler()

@end

@implementation FoodConnectionHandler

- (void)getTargetFoodNutrition:(NSString *)mTargetFood{
    
    NSString *query = [mTargetFood stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",foodNutritionURL, query]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", @"advisor", apiKey];
    NSData *authData = [authStr dataUsingEncoding:NSASCIIStringEncoding];
    NSString *base64EncodedAuthData = [authData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", base64EncodedAuthData];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    request.timeoutInterval = 5; // set timeout to 5 seconds
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error != nil || error.code == NSURLErrorTimedOut)
        {
            [self->_delegate FoodConnectionHandler:self didFinishTargetFood:NO fooddetail:nil foodRecipe:nil];
        }else if ([data length] > 0 && error == nil) {
            
            // success case:
            @try {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                NSMutableArray *FoodReceiptArray = [[NSMutableArray alloc] init];
                NSDictionary *FoodInformationDict = [dict objectForKey:@"nutrition"];
                FoodReceiptArray = [dict objectForKey:@"recipes"];
                NSMutableArray *recipetList =  [self getRecipeList:FoodReceiptArray];
//                NSMutableArray *mFoodInformation;
                NSMutableDictionary *mFoodInformation = [[NSMutableDictionary alloc]init];
                //filter the food nutrition <--no need for loop
  
                NSNumber *calories = [FoodInformationDict objectForKey:@"calories"];
                if([self checkNotNullValue:calories])
                {
                    [mFoodInformation setObject:calories forKey:@"Calories"];
                }
                
                NSNumber *totalFat = [FoodInformationDict objectForKey:@"fat_total_g"];
                if([self checkNotNullValue:totalFat])
                {
                    [mFoodInformation setObject:totalFat forKey:@"Total Fat"];
                }
                
                NSNumber *totalSatFat = [FoodInformationDict objectForKey:@"fat_saturated_g"];
                if([self checkNotNullValue:totalSatFat])
                {
                    [mFoodInformation setObject:totalSatFat forKey:@"Total Saturated Fat"];
                }
                
                NSNumber *carbohydrates = [FoodInformationDict objectForKey:@"carbohydrates_total_g"];
                if([self checkNotNullValue:carbohydrates])
                {
                    [mFoodInformation setObject:carbohydrates forKey:@"Carbohydrates"];
                }
                
                
                NSNumber *potassium = [FoodInformationDict objectForKey:@"potassium_mg"];
                if([self checkNotNullValue:potassium])
                {
                    [mFoodInformation setObject:[self convertMgtoG:potassium] forKey:@"Potassium"];
                }
                
                NSNumber *sodium = [FoodInformationDict objectForKey:@"sodium_mg"];
                if([self checkNotNullValue:sodium])
                {
                    [mFoodInformation setObject:[self convertMgtoG:sodium] forKey:@"Sodium"];
                }
                
                NSNumber *protein = [FoodInformationDict objectForKey:@"protein_g"];
                if([self checkNotNullValue:protein])
                {
                    [mFoodInformation setValue:protein forKey:@"Protein"];
                }
                
                NSNumber *sugar = [FoodInformationDict objectForKey:@"sugar_g"];
                if([self checkNotNullValue:sugar])
                {
                    [mFoodInformation setObject:sugar forKey:@"Sugar"];
                }
                
                NSNumber *fiber = [FoodInformationDict objectForKey:@"fiber_g"];
                if([self checkNotNullValue:fiber])
                {
                    [mFoodInformation setObject:fiber forKey:@"Fiber"];
                }
                
                NSNumber *cholesterol = [FoodInformationDict objectForKey:@"cholesterol_mg"];
                if([self checkNotNullValue:cholesterol])
                {
                    [mFoodInformation setObject:[self convertMgtoG:cholesterol] forKey:@"Cholesterol"];
                }
       

               [self->_delegate FoodConnectionHandler:self didFinishTargetFood:YES fooddetail:mFoodInformation foodRecipe:recipetList];

            }
            @catch (NSException * __unused exception) { }
        }else{
            [self->_delegate FoodConnectionHandler:self didFinishTargetFood:NO fooddetail:nil foodRecipe:nil];
        }
    
    }];
    
    [task resume];
}
-(NSNumber *)convertMgtoG:(NSNumber *)valueMg{
    double dbvalueG = [valueMg doubleValue]/1000;
    return [NSNumber numberWithDouble:dbvalueG];
}
-(BOOL)checkNotNullValue:(NSNumber *)foodValue{

    if ([foodValue compare:@0] == NSOrderedDescending) {
        NSLog(@"myNumber is greater than 0");
        return YES;
    } else {
        NSLog(@"myNumber is less than or equal to 0");
        return NO;
    }

}
-(NSMutableArray *)getRecipeList:(NSMutableArray *)FoodReceiptArray{
    NSMutableArray *mtempRecipt = [[NSMutableArray alloc] init];
    for(int i=0;i<FoodReceiptArray.count;i++){
        NSMutableDictionary *mtempitem = [[NSMutableDictionary alloc] init];
        NSDictionary *mRecipt = [FoodReceiptArray objectAtIndex:i];
        //id;
        NSString *myString = [[mRecipt objectForKey:@"id"] stringValue];

        [mtempitem setValue:myString  forKey:@"id"];
        //title name
        [mtempitem setValue:[mRecipt objectForKey:@"title"]  forKey:@"title"];
        [mtempitem setValue:[mRecipt objectForKey:@"image"]  forKey:@"image"];
//        mRecipt
        [mtempRecipt addObject:mtempitem];
    }
    return mtempRecipt;

}
- (void)getRecipeDetail:(NSString *)targetId{
//    for(int i=0;i<FoodReceiptArray.count;i++){
//        NSMutableDictionary *mtempitem = [[NSMutableDictionary alloc] init];
//        NSDictionary *mRecipt = [FoodReceiptArray objectAtIndex:i];
//        //id;
//        NSString *myString = [[mRecipt objectForKey:@"id"] stringValue];
//
//        [mtempitem setValue:myString  forKey:@"id"];
//        //title name
//        [mtempitem setValue:[mRecipt objectForKey:@"title"]  forKey:@"title"];
//        [mtempitem setValue:[mRecipt objectForKey:@"image"]  forKey:@"image"];
////        mRecipt
//        [mtempRecipt addObject:mtempitem];
//    }
//    return mtempRecipt;
    
    NSString *query = targetId;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",foodRecipeStep, query]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", @"advisor", apiKey];
    NSData *authData = [authStr dataUsingEncoding:NSASCIIStringEncoding];
    NSString *base64EncodedAuthData = [authData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", base64EncodedAuthData];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    request.timeoutInterval = 5; // set timeout to 5 seconds
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error != nil || error.code == NSURLErrorTimedOut)
        {
            [self->_delegate FoodConnectionHandler:self didFinishRecipeDetail:NO foodRecipe:nil];
        }else if ([data length] > 0 && error == nil) {
            
            // success case:
            @try {
                NSMutableArray *dictArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                NSMutableArray *FoodReceiptStep = [[NSMutableArray alloc] init];
                NSDictionary *dictDetail = [dictArray objectAtIndex:0];
            
                NSMutableArray *FoodReceiptDict =  [dictDetail objectForKey:@"steps"];
                for(int i = 0; i <FoodReceiptDict.count ;i++)
                {
                    NSMutableDictionary *mdetail = [[NSMutableDictionary alloc] init];
                    NSDictionary *mtargetdetail =  [FoodReceiptDict objectAtIndex:i];
                    NSString *mstep = [mtargetdetail objectForKey:@"step"];
                    [mdetail setValue:mstep forKey:@"step"];
                    NSString *number = [mtargetdetail objectForKey:@"number"];
                    [mdetail setValue:number forKey:@"number"];
                
                    [FoodReceiptStep addObject:mdetail];
                }
                [self->_delegate FoodConnectionHandler:self didFinishRecipeDetail:YES foodRecipe:FoodReceiptStep];

            }
            @catch (NSException * __unused exception) { }
        }else{
            [self->_delegate FoodConnectionHandler:self didFinishRecipeDetail:NO foodRecipe:nil];
        }
    
    }];
    
    [task resume];
}
@end
