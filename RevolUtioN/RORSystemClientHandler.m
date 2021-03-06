//
//  RORSystemClientHandler.m
//  RevolUtioN
//
//  Created by leon on 13-8-10.
//  Copyright (c) 2013年 Beyond. All rights reserved.
//

#import "RORSystemClientHandler.h"

@implementation RORSystemClientHandler

+(RORHttpResponse *)getVersionInfo:(NSString *) platform{
    NSString *url = [NSString stringWithFormat:VERSION_URL ,platform];
    RORHttpResponse *httpResponse = [RORHttpClientHandler getRequest:url];
    return httpResponse;
}

+(RORHttpResponse *)getSystemMessage:(NSString *) lastUpdateTime{
    NSString *url = [NSString stringWithFormat:SYSTEM_MESSAGE_URL, lastUpdateTime];
    RORHttpResponse *httpResponse = [RORHttpClientHandler getRequest:url];
    return httpResponse;
}

+(RORHttpResponse *)submitFeedback:(NSDictionary *) feedbackDic{
    RORHttpResponse *httpResponse = [RORHttpClientHandler postRequest:FEEDBACK_URL withRequstBody:[RORUtils toJsonFormObject:feedbackDic]];
    return httpResponse;
}

+(RORHttpResponse *)submitDownLoaded:(NSDictionary *) downLoadDic{
    RORHttpResponse *httpResponse = [RORHttpClientHandler postRequest:DOWNLOADED_URL withRequstBody:[RORUtils toJsonFormObject:downLoadDic]];
    return httpResponse;
}

+(RORHttpResponse *)getRecommendApp:(NSString *) lastUpdateTime{
    NSString *url = [NSString stringWithFormat:RECOMMEND_APP_URL, lastUpdateTime];
    RORHttpResponse *httpResponse = [RORHttpClientHandler getRequest:url];
    return httpResponse;
}


@end
