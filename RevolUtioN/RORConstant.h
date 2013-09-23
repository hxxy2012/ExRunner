//
//  RORConstant.h
//  RevolUtioN
//
//  Created by Beyond on 13-6-14.
//  Copyright (c) 2013年 Beyond. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef URLS
#define SERVICE_URL @"http://121.199.56.231:8080/usavich/service/api"
#define LOGIN_URL @"http://121.199.56.231:8080/usavich/service/api/account/%@/%@"
#define REGISTER_URL @"http://121.199.56.231:8080/usavich/service/api/account"
#define USER_ADDITIONAL_UPDATE @"http://121.199.56.231:8080/usavich/service/api/account/additional/%@"
#define USER_INFO @"http://121.199.56.231:8080/usavich/service/api/account/%@?checkUuid=true"
#define POST_RUNNING_HISTORY_URL @"http://121.199.56.231:8080/usavich/service/api/running/history/%@"
#define RUNNING_HISTORY_URL @"http://121.199.56.231:8080/usavich/service/api/running/history/%@?lastUpdateTime=%@"
#define POST_USER_RUNNING_URL @"http://121.199.56.231:8080/usavich/service/api/running/ongoing/%@"
#define USER_RUNNING_URL @"http://121.199.56.231:8080/usavich/service/api/running/ongoing/%@?lastUpdateTime=%@"
#define FRIEND_URL @"http://121.199.56.231:8080/usavich/service/api/account/friends/%@?lastUpdateTime=%@"
#define MISSION_URL @"http://121.199.56.231:8080/usavich/service/api/missions/mission?lastUpdateTime=%@"
#define VERSION_URL @"http://121.199.56.231:8080/usavich/service/api/system/version/%@"
#define SYSTEM_MESSAGE_URL @"http://121.199.56.231:8080/usavich/service/api/system/message/%@"
#define PM25_URL @"http://121.199.56.231:8080/usavich/service/api/weather/pm25?cityName=%@&provinceName=%@"


#define WEATHER_URL @"http://www.weather.com.cn/data/sk/%@.html"


#define DEFAULT_NET_WORK_MODE @"All_Mode"
#define NET_WORK_MODE_WIFI @"Only_Wifi"
#define DEFAULT_SEX @"男"
#define DEFAULT_WEIGHT [NSNumber numberWithDouble:60]
#define DEFAULT_HEIGHT [NSNumber numberWithDouble:175]
#define DEFAULT_SPEEDTYPE 0
#define DEFAULT_ANIMATION [NSNumber numberWithBool:YES]

#define CHN_PRINT_FONT @"FZKaTong-M19S"
#define CHN_WRITTEN_FONT @"FZKaTong-M19S"
#define ENG_WRITTEN_FONT @"Noteworthy"
#define ENG_PRINT_FONT @"Neotech"

#endif

typedef enum {Challenge = 0, Recommand = 1, Cycle = 2, SubCycle = 3, NormalRun = 4} MissionTypeEnum;
typedef enum {GRADE_S = 0, GRADE_A = 1, GRADE_B = 2, GRADE_C = 3, GRADE_D = 4, GRADE_E = 5, GRADE_F = 6} MissionGradeEnum;


NSString *const MissionTypeEnum_toString[5];
NSString *const MissionGradeEnum_toString[7];
NSString *const MissionGradeImageEnum_toString[7];

@interface RORConstant : NSObject

@end
