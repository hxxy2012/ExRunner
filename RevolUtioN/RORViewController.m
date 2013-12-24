//
//  RORViewController.m
//  RevolUtioN
//
//  Created by Bjorn on 13-8-20.
//  Copyright (c) 2013年 Beyond. All rights reserved.
//

#import "RORViewController.h"
#import "FTAnimation.h"

@interface RORViewController ()

@end

@implementation RORViewController
@synthesize backButton;
@synthesize activityIndicator = _activityIndicator;
@synthesize progressView = _progressView;


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
//    [self startIndicator:self];
    [self.view setAutoresizesSubviews:YES];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self addBackButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didAppearNotification:)
                                                 name:SVProgressHUDDidAppearNotification
                                               object:nil];
}

-(void)viewDidUnload{
    [self setBackButton:nil];
    [self setActivityIndicator:nil];
    [self setProgressView:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [self endIndicator:self];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)addBackButton{
    backButton = [[RORNormalButton alloc]initWithFrame:BACKBUTTON_FRAME_TOP ];//[RORNormalButton buttonWithType:UIButtonTypeRoundedRect];
//    [backButton initButtonInteraction];
    backButton.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
    //CGRect rx = [ UIScreen mainScreen ].applicationFrame;
//    backButton.frame = BACKBUTTON_FRAME_TOP;
//    if (rx.size.height == 460){
//        backButton.frame = BACKBUTTON_FRAME_NORMAL;
//    } else {
//        backButton.frame = BACKBUTTON_FRAME_RETINA;
//    }
    UIImage *image = [UIImage imageNamed:@"back_bg.png"];
    [backButton setBackgroundImage:image forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sendNotification:(NSString *)message{
    if ([message rangeOfString:@"失败"].location != NSNotFound ||
        [message rangeOfString:@"无法"].location != NSNotFound ||
        [message rangeOfString:@"错误"].location != NSNotFound){
        [SVProgressHUD showErrorWithStatus:message];
    } else if ([message rangeOfString:@"成功"].location != NSNotFound ||
               [message rangeOfString:@"完成"].location != NSNotFound){
        [SVProgressHUD showSuccessWithStatus:message];
    } else
        [SVProgressHUD showImage:nil status:message];
}

-(void)sendSuccess:(NSString *)message{
    [SVProgressHUD showSuccessWithStatus:message];
}

-(void)sendAlart:(NSString *)message{
//    if (notificationView == nil){
//        notificationView = [[RORNotificationView alloc]init];
//        [self.view addSubview:notificationView];
//    }
//    [notificationView popNotification:self Message:message andType:RORNOTIFICATION_TYPE_IMPORTANT];
    [SVProgressHUD showErrorWithStatus:message];
}

-(IBAction)didAppearNotification:(id)sender{
//    [SVProgressHUD dismiss];
}

/**
activity indicator
*/

- (IBAction)startIndicator:(id)sender
{
    [SVProgressHUD showWithStatus:nil maskType:SVProgressHUDMaskTypeClear];
}

- (IBAction)endIndicator:(id)sender{
//    [self.activityIndicator stopAnimating];
    [SVProgressHUD dismiss];
}

- (IBAction)startProgress:(id)sender
{
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(70, 260, 180, 20)];
    /*
     设置风格属性
     有两种风格属性：
     UIProgressViewStyleDefault
     UIProgressViewStyleBar
     */
    self.progressView.progressViewStyle = UIProgressViewStyleDefault;
    
    //设置进度，值为0——1.0的浮点数
    //    self.progressView.progress = .5;
    [self.view addSubview:self.progressView];
    
    //设定计时器，每隔1s调用一次runProgress方法
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runProgress)   userInfo:nil repeats:YES];
}

//在状态栏显示有网络请求的提示器
- (IBAction)startNetWork:(id)sender
{
    UIApplication *app = [UIApplication sharedApplication];
    if (app.isNetworkActivityIndicatorVisible) {
        app.networkActivityIndicatorVisible = NO;
    }else {
        app.networkActivityIndicatorVisible = YES;
    }
}

-(void)runIndicator
{
    //开启线程并睡眠三秒钟
    [NSThread sleepForTimeInterval:3];
    //停止UIActivityIndicatorView
    [self.activityIndicator stopAnimating];
}

//增加progressView的进度
-(void)runProgress
{
    self.progressView.progress += .1;
}

@end
