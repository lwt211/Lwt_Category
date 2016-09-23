//
//  NSObject+UserCache.m
//  App
//
//  Created by 李文韬 on 16/1/19.
//  Copyright © 2016年 com.wentao. All rights reserved.
//

#import "NSObject+UserCache.h"

#define LAST_RUN_VERSION_KEY        @"last_run_version_of_application"


@implementation NSObject (UserCache)

+ (BOOL)isFirstOpen
{
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary]
                                objectForKey:@"CFBundleShortVersionString"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastRunVersion = [defaults objectForKey:LAST_RUN_VERSION_KEY];
    
    if (!lastRunVersion) {
        [defaults setObject:currentVersion forKey:LAST_RUN_VERSION_KEY];
        return YES;
        // App is being run for first time
    }
    else if (![lastRunVersion isEqualToString:currentVersion])
    {
        [defaults setObject:currentVersion forKey:LAST_RUN_VERSION_KEY];
        return YES;
        // App has been updated since last run
    }
    return NO;
}


+ (void)saveIsLogin:(BOOL)isLogin
{
    [UserDefaults setBool:isLogin forKey:@"isLogin"];
    [UserDefaults synchronize];
}


+ (BOOL)isLogin
{
    return [[UserDefaults objectForKey:@"isLogin"] boolValue];
}



+ (void)autoLogin:(BOOL)isAuto
{
    [UserDefaults setBool:isAuto forKey:@"isAuto"];
    [UserDefaults synchronize];
}

+ (BOOL)isAuto
{
    return [[UserDefaults objectForKey:@"isAuto"] boolValue];
    
}


+ (void)saveToken:(NSString *)token
{
    [UserDefaults setObject:token forKey:@"token"];
    [UserDefaults synchronize];
}

+ (NSString *)getToken
{
    return [UserDefaults objectForKey:@"token"];
}


+ (void)saveIsRemenberPassWord:(BOOL)Bool
{
    [UserDefaults setBool:Bool forKey:@"remenberPassWord"];
    [UserDefaults synchronize];
}

+ (BOOL)isRemenberPassWord
{
    return [[UserDefaults objectForKey:@"remenberPassWord"] boolValue];
}




+ (void)saveCurrentCity:(NSString *)city
{
    
    [UserDefaults setObject:city forKey:@"currentCity"];
    [UserDefaults synchronize];
}

+ (NSString *)getCurrentCity
{
    return [UserDefaults objectForKey:@"currentCity"];
}


+ (void)saveUserInfo:(NSDictionary *)userInfo
{
    
    [UserDefaults setObject:userInfo forKey:@"userInfo"];
    [UserDefaults synchronize];
}

+ (NSDictionary *)getUserInfo
{
    return [UserDefaults objectForKey:@"userInfo"];
}

+ (NSString *)getUserName
{
    return [[UserDefaults objectForKey:@"userInfo"] objectForKey:@"loginName"];
}

+ (NSString *)getUerId
{
    
    return [[UserDefaults objectForKey:@"userInfo"] objectForKey:@"userId"];
}



@end
