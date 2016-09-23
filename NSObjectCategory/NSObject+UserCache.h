//
//  NSObject+UserCache.h
//  App
//
//  Created by 李文韬 on 16/1/19.
//  Copyright © 2016年 com.wentao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (UserCache)

//是否第一次进入App
+ (BOOL)isFirstOpen;


//是否登录
+ (void)saveIsLogin:(BOOL)isLogin;
+ (BOOL)isLogin;


//是否自动登录
+ (void)autoLogin:(BOOL)isAuto;
+ (BOOL)isAuto;


//是否记住密码
+ (void)saveIsRemenberPassWord:(BOOL)Bool;
+ (BOOL)isRemenberPassWord;


/**
 *  保存和提取用户token
 */
+ (void)saveToken:(NSString *)token;
+ (NSString *)getToken;


//保存当前城市
+ (void)saveCurrentCity:(NSString *)city;
+ (NSString *)getCurrentCity;


//保存用户资料 和提取用户资料
+ (void)saveUserInfo:(NSDictionary *)userInfo;
+ (NSDictionary *)getUserInfo;
+ (NSString *)getUserName;
+ (NSString *)getUerId;


@end
