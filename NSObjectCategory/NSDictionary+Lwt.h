//
//  NSDictionary+Lwt.h
//  App
//
//  Created by 李文韬 on 16/1/14.
//  Copyright © 2016年 com.wentao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Lwt)

- (NSDictionary *)CheckNullInDic;

- (BOOL)getBoolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue;

- (int)getIntValueForKey:(NSString *)key defaultValue:(int)defaultValue;

- (long long)getLongLongValueValueForKey:(NSString *)key defaultValue:(long long)defaultValue;

- (NSString *)getStringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue;

- (NSNumber *)getNumberValueForKey:(NSString *)key defaultValue:(NSNumber *)defaultValue;

@end
