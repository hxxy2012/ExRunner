//
//  User_Attributes.m
//  RevolUtioN
//
//  Created by leon on 13828.
//  Copyright (c) 2013年 Beyond. All rights reserved.
//

#import "User_Attributes.h"
#import "RORDBCommon.h"

@implementation User_Attributes

@dynamic age;
@dynamic baseAcc;
@dynamic crit;
@dynamic endurance;
@dynamic experience;
@dynamic height;
@dynamic inertiaAcc;
@dynamic level;
@dynamic luck;
@dynamic maxPower;
@dynamic rapidly;
@dynamic recoverSpeed;
@dynamic remainingPower;
@dynamic scores;
@dynamic spirit;
@dynamic userId;
@dynamic weight;
@dynamic totalDistance;
@dynamic avgSpeed;
@dynamic spendCarlorie;
@dynamic totalRunTimes;

+(User_Attributes *) intiUnassociateEntity{
    NSManagedObjectContext *context = [RORContextUtils getShareContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User_Attributes" inManagedObjectContext:context];
    User_Attributes *unassociatedEntity = [[User_Attributes alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
    return unassociatedEntity;
}

+(User_Attributes *) removeAssociateForEntity:(User_Attributes *)associatedEntity{
    NSManagedObjectContext *context = [RORContextUtils getShareContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User_Attributes" inManagedObjectContext:context];
    User_Attributes *unassociatedEntity = [[User_Attributes alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
    for (NSString *attr in [[entity attributesByName] allKeys]) {
        [unassociatedEntity setValue:[associatedEntity valueForKey:attr] forKey:attr];
    }
    return unassociatedEntity;
}

-(void)initWithDictionary:(NSDictionary *)dict{
    self.userId = [RORDBCommon getNumberFromId:[dict valueForKey:@"userId"]];
    self.level = [RORDBCommon getNumberFromId:[dict valueForKey:@"level"]];
    self.crit = [RORDBCommon getNumberFromId:[dict valueForKey:@"crit"]];
    self.baseAcc = [RORDBCommon getNumberFromId:[dict valueForKey:@"baseAcc"]];
    self.experience = [RORDBCommon getNumberFromId:[dict valueForKey:@"experience"]];
    self.inertiaAcc = [RORDBCommon getNumberFromId:[dict valueForKey:@"inertiaAcc"]];
    self.luck = [RORDBCommon getNumberFromId:[dict valueForKey:@"luck"]];
    self.scores = [RORDBCommon getNumberFromId:[dict valueForKey:@"scores"]];
    self.maxPower = [RORDBCommon getNumberFromId:[dict valueForKey:@"maxPower"]];
    self.remainingPower = [RORDBCommon getNumberFromId:[dict valueForKey:@"remainingPower"]];
    self.endurance = [RORDBCommon getNumberFromId:[dict valueForKey:@"endurance"]];
    self.spirit = [RORDBCommon getNumberFromId:[dict valueForKey:@"spirit"]];
    self.rapidly = [RORDBCommon getNumberFromId:[dict valueForKey:@"rapidly"]];
    self.recoverSpeed = [RORDBCommon getNumberFromId:[dict valueForKey:@"recoverSpeed"]];
    self.age = [RORDBCommon getNumberFromId:[dict valueForKey:@"age"]];
    self.weight = [RORDBCommon getNumberFromId:[dict valueForKey:@"weight"]];
    self.height = [RORDBCommon getNumberFromId:[dict valueForKey:@"height"]];
    self.totalDistance = [RORDBCommon getNumberFromId:[dict valueForKey:@"totalDistance"]];
    self.avgSpeed = [RORDBCommon getNumberFromId:[dict valueForKey:@"avgSpeed"]];
    self.spendCarlorie = [RORDBCommon getNumberFromId:[dict valueForKey:@"spendCarlorie"]];
    self.totalRunTimes = [RORDBCommon getNumberFromId:[dict valueForKey:@"totalRunTimes"]];   
}

@end
