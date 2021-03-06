//
//  RORSystemService.h
//  RevolUtioN
//
//  Created by leon on 13-8-10.
//  Copyright (c) 2013年 Beyond. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RORAppDelegate.h"
#import "RORHttpResponse.h"
#import "RORSystemClientHandler.h"
#import "Version_Control.h"
#import "System_Message.h"
#import "RORContextUtils.h"
#import "Recommend_App.h"

@interface RORSystemService : NSObject

+(Version_Control *)syncVersion:(NSString *)platform;

+(BOOL)syncSystemMessage;

+(NSString *)getSystemMessage:(NSNumber *)messageId;

+(NSString *)getSystemMessage:(NSNumber *)messageId withRegion:(NSNumber *)region;

+(BOOL)submitFeedback:(NSDictionary *)feedbackDic;

+(BOOL)submitDownloaded:(NSDictionary *)downLoadDic;

+(BOOL)syncRecommendApp;

+(NSArray *)fetchAllRecommedInfo;
@end
