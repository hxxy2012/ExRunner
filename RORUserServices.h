//
//  RORUserServices.h
//  RevolUtioN
//
//  Created by leon on 13-7-14.
//  Copyright (c) 2013年 Beyond. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User_Base.h"
#import "Friend.h"
#import "User_Attributes.h"
#import "RORAppDelegate.h"
#import "RORContextUtils.h"
#import "RORHttpResponse.h"
#import "RORUserClientHandler.h"
#import "Plan_User_Follow.h"
#import "User_Last_Location.h"

@interface RORUserServices : NSObject

+ (User_Base *)fetchUser:(NSNumber *) userId;

+(User_Attributes *)fetchUserAttrsByUserId:(NSNumber *) userId;

+(User_Base *)registerUser:(NSDictionary *)registerDic;

+(User_Base *)syncUserInfoById:(NSNumber *)userId;

+(User_Base *)syncUserInfoByLogin:(NSString *)userName withUserPasswordL:(NSString *) password;

+(BOOL)syncFriends:(NSNumber *) userId;

+(void)clearUserData;

+(User_Base *)updateUserInfo:(NSDictionary *)updateDic;

+(BOOL)syncFollowersDetails:(NSNumber *) userId withPageNo:(NSNumber *) pageNo;

+(NSMutableArray *)fetchFollowersDetails:(NSNumber *) userId withPageNo:(NSNumber *) pageNo;

+(BOOL)uploaduserLocation:(User_Last_Location *) userLastLocation;

@end
