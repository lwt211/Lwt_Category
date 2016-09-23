//
//  NSDate+Lwt.h
//  App
//
//  Created by 李文韬 on 16/1/14.
//  Copyright © 2016年 com.wentao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Lwt)

-(int)day;
-(int)month;
-(int)year;
-(int)nextDay;
-(int)preDay;

-(NSDate*)nextWeek;
-(NSDate*)preWeek;

-(NSDate*)nextDate;
-(NSDate*)preDate;

-(NSDate*)weekMonday;
-(NSDate*)natualWeekFirstDay;

-(NSDate*)monthFirstDay;
-(NSDate*)nextMonth;
-(NSDate*)preMonth;

-(NSDate*)dayStart;
-(NSDate*)dayEnd;

-(NSDate*)nextYearFirstDay;
-(NSDate*)preYearFirstDay;
-(NSDate*)yearEnd;
-(NSDate*)yearFirst;

-(NSDate*)yearLastWeekMonday;
-(NSDate*)weekEnd;

-(NSString*)dateStringFormat:(NSString*)ft;
-(NSString*)dateStr;

//是否是同一时间date  返回yes
-(BOOL)compareDate:(NSDate*)date;

//大于date  返回yes
-(BOOL)comparewithDate:(NSDate *)date;


//判断是否是同一天 周 月 年
-(BOOL)isEqualDay:(NSDate*)date;

-(BOOL)isEqualWeek:(NSDate*)date;

-(BOOL)isEqualMOnth:(NSDate*)date;

-(BOOL)isEqualYear:(NSDate*)date;


+(NSString *)currentDate;

+(NSString *)currentDate:(NSString*)pattern;

/**
 *  毫秒 转换成时间
 */

+ (NSString *)dateFromeMillisecond:(NSString *)millisecond;


/**
 *  到当前时间的时长
 */

+ (NSString *)getHoursAndMunit:(NSString *)toTime;


/**
 *  计算时间差
 */

+ (NSString * )timeDiff:(NSString *)fromTime  toTime:(NSString *)toTime;


@end
