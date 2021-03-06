//
//  RORTrainingDetailViewController.m
//  Cyberace
//
//  Created by Bjorn on 13-11-20.
//  Copyright (c) 2013年 Beyond. All rights reserved.
//

#import "RORTrainingDetailViewController.h"
#import "RORTrainingMainViewController.h"

@interface RORTrainingDetailViewController ()

@end

@implementation RORTrainingDetailViewController
@synthesize plan, planNext;
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
    planNext = [RORPlanService fetchUserRunningPlanHistory];
//    plan = planNext.planInfo;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)collectAction:(id)sender{
    if ([RORUserUtils getUserId].integerValue>0){
        [RORPlanService collectPlan:plan];
        UIButton *btn = (UIButton *)sender;
        btn.enabled = NO;
        [self refreshCollectButton:btn];
        [self sendNotification:@"收藏成功！"];
    } else
        [self sendAlart:@"请先登录"];
}

-(void)refreshCollectButton:(UIButton *)btn{
    if (btn.enabled){
        [btn setTitle:@"收藏" forState:UIControlStateNormal];
    } else {
        [btn setTitle:@"已收藏" forState:UIControlStateNormal];
    }
}

-(BOOL)isCollectAvailable{
    NSArray *collectList = [RORPlanService fetchPlanCollect:[RORUserUtils getUserId]];
    for (Plan *itPlan in collectList)
        if (itPlan.planId.integerValue == plan.planId.integerValue)
            return NO;
    
    return YES;
}

-(IBAction)operateAction:(id)sender{
    if ([RORUserUtils getUserId].integerValue>0){
        planNext = [RORPlanService startNewPlan:plan.planId];
        
        //这里没为planNext判空，不知道会不会有问题
        
        //    [RORPlanService refreshTrainingNotification:planNext];
        
        UIViewController *viewController = delegate;
        
        while (![viewController isKindOfClass:[RORTrainingMainViewController class]]) {
            viewController = (UIViewController *)[viewController valueForKey:@"delegate"];
        }
        
        [self.navigationController popToViewController:viewController animated:YES];
    } else
        [self sendAlart:@"请先登录"];
}
@end
