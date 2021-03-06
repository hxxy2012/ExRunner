//
//  Plan_Run_History.m
//  Cyberace
//
//  Created by leon on 13-11-14.
//  Copyright (c) 2013年 Beyond. All rights reserved.
//

#import "Plan_Run_History.h"
#import "RORDBCommon.h"

@implementation Plan_Run_History

@dynamic endTime;
@dynamic historyStatus;
@dynamic lastUpdateTime;
@dynamic nextMissionId;
@dynamic planId;
@dynamic planRunUuid;
@dynamic rate;
@dynamic rateComment;
@dynamic remainingMissions;
@dynamic startTime;
@dynamic totalMissions;
@dynamic userId;
@dynamic operate;

@synthesize nickName;
@synthesize planName;
@synthesize userSex;

@synthesize runHistoryList;

+(Plan_Run_History *) intiUnassociateEntity{
    NSManagedObjectContext *context = [RORContextUtils getShareContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Plan_Run_History" inManagedObjectContext:context];
    Plan_Run_History *unassociatedEntity = [[Plan_Run_History alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
    return unassociatedEntity;
}

+(Plan_Run_History *) removeAssociateForEntity:(Plan_Run_History *)associatedEntity{
    NSManagedObjectContext *context = [RORContextUtils getShareContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Plan_Run_History" inManagedObjectContext:context];
    Plan_Run_History *unassociatedEntity = [[Plan_Run_History alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
    for (NSString *attr in [[entity attributesByName] allKeys]) {
        [unassociatedEntity setValue:[associatedEntity valueForKey:attr] forKey:attr];
    }
    NSMutableArray *newHistoryList = [[NSMutableArray alloc] init];
    for (User_Running_History *newHistory in associatedEntity.runHistoryList) {
        [newHistoryList addObject:[User_Running_History removeAssociateForEntity:newHistory]];
    }
    unassociatedEntity.runHistoryList = newHistoryList;
    unassociatedEntity.nickName = associatedEntity.nickName;
    unassociatedEntity.planName = associatedEntity.planName;
    unassociatedEntity.userSex = associatedEntity.userSex;
    return unassociatedEntity;
}

-(void)initWithDictionary:(NSDictionary *)dict{
    self.endTime = [RORDBCommon getDateFromId:[dict valueForKey:@"endTime"]];
    self.historyStatus = [RORDBCommon getNumberFromId:[dict valueForKey:@"historyStatus"]];
    self.lastUpdateTime = [RORDBCommon getDateFromId:[dict valueForKey:@"lastUpdateTime"]];
    self.nextMissionId = [RORDBCommon getNumberFromId:[dict valueForKey:@"nextMissionId"]];
    self.planId = [RORDBCommon getNumberFromId:[dict valueForKey:@"planId"]];
    self.planName = [RORDBCommon getStringFromId:[dict valueForKey:@"planName"]];
    self.planRunUuid = [RORDBCommon getStringFromId:[dict valueForKey:@"planRunUuid"]];
    self.rate = [RORDBCommon getNumberFromId:[dict valueForKey:@"rate"]];
    self.rateComment = [RORDBCommon getStringFromId:[dict valueForKey:@"rateComment"]];
    self.remainingMissions = [RORDBCommon getNumberFromId:[dict valueForKey:@"remainingMissions"]];
    self.startTime = [RORDBCommon getDateFromId:[dict valueForKey:@"startTime"]];
    self.totalMissions = [RORDBCommon getNumberFromId:[dict valueForKey:@"totalMissions"]];
    self.userId = [RORDBCommon getNumberFromId:[dict valueForKey:@"userId"]];
    self.nickName = [RORDBCommon getStringFromId:[dict valueForKey:@"nickName"]];
    self.userSex = [RORDBCommon getStringFromId:[dict valueForKey:@"sex"]];
    self.operate = nil;
}

-(NSMutableDictionary *)transToDictionary{
    NSMutableDictionary *tempoDict = [[NSMutableDictionary alloc] init];
    [tempoDict setValue:[RORDBCommon getStringFromId:self.endTime] forKey:@"endTime"];
    [tempoDict setValue:self.historyStatus forKey:@"historyStatus"];
    [tempoDict setValue:[RORDBCommon getStringFromId:self.lastUpdateTime] forKey:@"lastUpdateTime"];
    [tempoDict setValue:self.nextMissionId forKey:@"nextMissionId"];
    [tempoDict setValue:self.planRunUuid forKey:@"planRunUuid"];
    [tempoDict setValue:self.planId forKey:@"planId"];
    [tempoDict setValue:self.rate forKey:@"rate"];
    [tempoDict setValue:self.rateComment forKey:@"rateComment"];
    [tempoDict setValue:self.remainingMissions forKey:@"remainingMissions"];
    [tempoDict setValue:[RORDBCommon getStringFromId:self.startTime] forKey:@"startTime"];
    [tempoDict setValue:self.totalMissions forKey:@"totalMissions"];
    [tempoDict setValue:self.userId forKey:@"userId"];
    [tempoDict setValue:self.operate forKey:@"operate"];
    [tempoDict setValue:self.userSex forKey:@"sex"];
    return tempoDict;
}

@end
