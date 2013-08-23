//
//  RORHistoryDetailViewController.m
//  RevolUtioN
//
//  Created by Beyond on 13-6-7.
//  Copyright (c) 2013年 Beyond. All rights reserved.
//

#import "RORHistoryDetailViewController.h"
#import "RORRunningViewController.h"
#import "RORDBCommon.h"
#import "RORUtils.h"
#import "RORShareService.h"

@interface RORHistoryDetailViewController ()
    
@end

@implementation RORHistoryDetailViewController{

    UIImage *img;
}

@synthesize distanceLabel, speedLabel, durationLabel, energyLabel, weatherLabel, scoreLabel, experienceLabel, bonusLabel;
@synthesize record;
@synthesize coverView;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    distanceLabel.text = [NSString stringWithFormat:@"%.2f", [record.distance floatValue]];
    speedLabel.text = [NSString stringWithFormat:@"%.1f", [record.avgSpeed floatValue]];
    durationLabel.text = [RORUtils transSecondToStandardFormat:[record.duration integerValue]];
    energyLabel.text = [NSString stringWithFormat:@"%d", [record.spendCarlorie integerValue]];
    scoreLabel.text = [NSString stringWithFormat:@"%d", [record.scores integerValue]];
    experienceLabel.text = [NSString stringWithFormat:@"%d" ,[record.experience integerValue]];
//    [self.navigationItem.backBarButtonItem setAction:@selector(backToMain:)];
//    [delegate viewDidLoad];
}

//-(void)backToMain:(id)sender {
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setDistanceLabel:nil];
    [self setSpeedLabel:nil];
    [self setDurationLabel:nil];
    [self setEnergyLabel:nil];
    [self setWeatherLabel:nil];
    [self setScoreLabel:nil];
    [self setExperienceLabel:nil];
    [self setBonusLabel:nil];
    [self setBackButtonItem:nil];
    [self setRecord:nil];
    [self setDelegate:nil];
    [self setBackButtonItem:nil];
    [self setCoverView:nil];
    [super viewDidUnload];
}

- (UIImage *) captureScreen {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGRect contentRectToCrop = CGRectMake(0, 70, image.size.width, image.size.height - 70);
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], contentRectToCrop);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    return croppedImage;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *destination = segue.destinationViewController;
    if ([destination respondsToSelector:@selector(setDelegate:)]){
        [destination setValue:self forKey:@"delegate"];
    }
    if ([destination respondsToSelector:@selector(setRoutePoints:)]){
        [destination setValue:[RORDBCommon getRoutePointsFromString:record.missionRoute] forKey:@"routePoints"];
    }
    if ([destination respondsToSelector:@selector(setShareImage:)]){
        [destination setValue:img forKey:@"shareImage"];
    }
}

- (IBAction)backAction:(id)sender {
    if ([delegate isKindOfClass:[RORRunningViewController class]]){
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else
        [self.navigationController popViewControllerAnimated:YES];
}

<<<<<<< HEAD
- (IBAction)shareToWeixin:(id)sender {
    //发送内容给微信
    id<ISSContent> content = [ShareSDK content:nil
                                defaultContent:nil
                                         image:[ShareSDK jpegImageWithImage:img quality:1]
                                         title:nil
                                           url:nil
                                   description:nil
                                     mediaType:SSPublishContentMediaTypeImage];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    
    
    [ShareSDK shareContent:content
                      type:ShareTypeWeixiTimeline
               authOptions:authOptions
             statusBarTips:YES
                    result:^(ShareType type, SSPublishContentState state, id<ISSStatusInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        if (state == SSPublishContentStateSuccess)
                        {
                            NSLog(@"success");
                        }
                        else if (state == SSPublishContentStateFail)
                        {
                            if ([error errorCode] == -22003)
                            {
                                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                                    message:[error errorDescription]
                                                                                   delegate:nil
                                                                          cancelButtonTitle:@"知道了"
                                                                          otherButtonTitles:nil];
                                [alertView show];
                            }
                        }
                    }];

}

- (IBAction)shareAction:(id)sender {
    img = [self captureScreen];
    [Animations fadeIn:coverView andAnimationDuration:0.3 toAlpha:1 andWait:NO];
    [Animations fadeOut:self.backButton andAnimationDuration:0.3 fromAlpha:1 andWait:YES];
}

- (IBAction)hideCover:(id)sender {
    [Animations fadeOut:coverView andAnimationDuration:0.3 fromAlpha:1 andWait:NO];
    [Animations fadeIn:self.backButton andAnimationDuration:0.3 toAlpha:1 andWait:YES];
}

@end
