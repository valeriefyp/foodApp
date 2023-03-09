#import "welcomeMain.h"
#import "UIImage+animatedGIF.h"
#import "ViewController.h"

@interface welcomeMain ()
@end

@implementation welcomeMain

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *gifFilePath = [[NSBundle mainBundle] pathForResource:@"Foody" ofType:@"gif"];
    NSData *gifData = [NSData dataWithContentsOfFile:gifFilePath];
    UIImage *animatedImage = [UIImage animatedImageWithAnimatedGIFData:gifData];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    
    imageView.image = animatedImage;

    [self.view addSubview:imageView];
    double delayInSeconds = animatedImage.duration ; // Add a half-second delay to account for animation loading time
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // Present the next view controller full screen
        UIViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"foodApp"];
        nextVC.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:nextVC animated:YES completion:nil];
//        [self performSegueWithIdentifier:@"foodApp" sender:self];

    });
}

@end
