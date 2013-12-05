//
//  RORSearchTrainingViewController.m
//  Cyberace
//
//  Created by Bjorn on 13-11-7.
//  Copyright (c) 2013年 Beyond. All rights reserved.
//

#import "RORSearchTrainingViewController.h"
#import "FTAnimation.h"

@interface RORSearchTrainingViewController ()

@end

@implementation RORSearchTrainingViewController
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
    self.backButton.alpha = 0;
    expanded = NO;
    isTableEmpty = YES;
    currentPages = 0;
    noMoreData = NO;
    searching = 0;
    collectList = [RORPlanService fetchPlanCollect:[RORUserUtils getUserId]];
    planNext = [RORPlanService fetchUserRunningPlanHistory];

    
    contentList = [[NSMutableArray alloc]init];
    [self loadTableViewData:currentPages++];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)expandAction:(id)sender {
    CGRect f = self.view.frame;
    
    if (!expanded) {
        expanded = YES;
        searchViewTop = f.origin.y;
        [self.view moveUp:0.5 length:-searchViewTop delegate:self];
        self.view.frame = CGRectMake(f.origin.x, 0, f.size.width, f.size.height);
    } else {
        expanded = NO;
        [self.view moveUp:0.5 length:searchViewTop delegate:self];
        self.view.frame = CGRectMake(f.origin.x, searchViewTop, f.size.width, f.size.height);
    }
}

-(void)loadTableViewData:(NSInteger)page{
    if (noMoreData)
        return;
    
    int count = contentList.count;
    NSArray *array = [RORPlanService getTopPlansList:[NSNumber numberWithInteger:page]];
    [contentList addObjectsFromArray:array];
    if (contentList.count-count<PLAN_PAGE_SIZE){
        noMoreData = YES;
    }
    [self.tableView reloadData];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    UIViewController *destination = segue.destinationViewController;
    if ([destination respondsToSelector:@selector(setDelegate:)]){
        [destination setValue:self forKey:@"delegate"];
    }
    if ([destination respondsToSelector:@selector(setPlan:)]){
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Plan *planNoDetail = (Plan *)[contentList objectAtIndex:indexPath.row];
        Plan *plan = [RORPlanService syncPlan:planNoDetail.planId];
        NSLog(@"%d", indexPath.row);
        [destination setValue:plan forKey:@"plan"];
    }
}

- (IBAction)prepare4SearchAction:(id)sender {
//    [self.searchTextField popUp:0.5 delegate:self targetPoint:self.searchTextField.center];
    [Animations frameAndShadow:self.searchTextField];
}

- (IBAction)doSearchAction:(id)sender {
//    [self.searchTextField popDown:0.5 delegate:self targetPoint:self.searchTextField.center];
    [Animations removeFrameAndShadow:self.searchTextField];
    
    UITextField *textField = (UITextField *)sender;
    NSNumber *planId =[RORDBCommon getNumberFromId:textField.text];
    if (!planId){
        textField.text = @"";
        if (searching)
            contentList = backupContentList;
        searching = NO;
        [self.tableView reloadData];
    } else {
        Plan *resultPlan = [RORPlanService fetchPlan:planId];
        if (!resultPlan){
            [self sendAlart:@"没找到这个训练！"];
            if (searching)
                contentList = backupContentList;
            searching = NO;
            [self.tableView reloadData];
            return;
        }
        if (!searching)
            backupContentList = contentList;
        contentList = [NSMutableArray arrayWithObjects:resultPlan, nil];
        searching = YES;
        [self.tableView reloadData];
    }
}

-(BOOL)isCollectAvailable:(Plan *)plan{
    for (Plan *itPlan in collectList)
        if (itPlan.planId.integerValue == plan.planId.integerValue)
            return NO;
    return YES;
}

-(void)operateAction:(Plan *)plan{
    
    [RORPlanService startNewPlan:plan.planId];
    
}

-(void)collectAction:(Plan *)plan{
    [RORPlanService collectPlan:plan];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (searching)
        return contentList.count;
    return contentList.count +1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if (indexPath.row == contentList.count) {
        static NSString *CellIdentifier = @"moreCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        UILabel *titleLabel = (UILabel *)[cell viewWithTag:100];
        titleLabel.text = @"目前只有这么多";
        return cell;
    }
    
    Plan *thisPlan = [contentList objectAtIndex:indexPath.row];
    NSNumber *planType = thisPlan.planType;
    

    if (planType.integerValue == PlanTypeEasy){
        static NSString *CellIdentifier = @"simpleTrainingCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        UILabel *timesLabel = (UILabel *)[cell viewWithTag:CELLTAG_TIMES];

        timesLabel.text = [NSString stringWithFormat:@"%@次/%@天",thisPlan.totalMissions, thisPlan.durationLast];
        
        
    } else if (planType.integerValue == PlanTypeComplex){
        static NSString *CellIdentifier = @"advTrainingCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        for (NSNumber *missionID in thisPlan.missionList){
//            Plan *detailPlan = [RORPlanService fetchPlan:missionID];
//        }
        UILabel *timesLabel = (UILabel *)[cell viewWithTag:CELLTAG_TIMES];
        timesLabel.text = [NSString stringWithFormat:@"%@次",thisPlan.totalMissions];

    }
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:CELLTAG_TITLE];
    titleLabel.text = thisPlan.planName;
    UIView *note = (UIView *)[cell viewWithTag:102];
    BOOL showNote = [self isCollectAvailable:thisPlan];
    note.alpha = showNote;

//    if (showNote)
//        note.alpha = 1;
//    else
//        note.alpha = 0;

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == contentList.count){
        [self loadTableViewData:currentPages++];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<contentList.count)
        return 77;
    return 50;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (planNext) {
        if (indexPath.row >= contentList.count)
            return NO;
        else {
            UIView *note = [cell viewWithTag:102];
            return (int)note.alpha;
        }
    }
    return YES;
}

//更改删除按钮
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (planNext)
        return @"收藏";
    return @"执行";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Plan *plan = [contentList objectAtIndex:indexPath.row];

    if (planNext){
        [self collectAction:plan];
        [self.tableView reloadData];
    } else {
        [self operateAction:plan];
        [self.tableView reloadData];
    }
}
@end
