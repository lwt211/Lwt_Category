//
//  NSDate+Lwt.m
//  App
//
//  Created by 李文韬 on 16/1/14.
//  Copyright © 2016年 com.wentao. All rights reserved.
//

#import "NSDate+Lwt.h"
#import "NSCalendar+Lwt.h"

#pragma mark - DateFormat
NSString * const  YU_DateFormatNill = @"0000-00-00 00:00:00.000";
NSString * const  YU_DefaultDateFormat =  @"yyyy-MM-dd HH:mm:ss";
NSString * const  YU_DefaultDateFormat_SSS =  @"yyyyMMddHHmmssSSS";

NSString * const  YU_DateFormat_01 =  @"yyyy-MM-dd HH:mm:ss.SSS";
NSString * const  YU_DateFormat_02 =  @"yyyy-MM-dd HH:mm:ss";
NSString * const  YU_DateFormat_03 =  @"yyyy-MM-dd HH:mm";
NSString * const  YU_DateFormat_04 =  @"yyyy-MM-dd HH";
NSString * const  YU_DateFormat_05 =  @"yyyy-MM-dd";
NSString * const  YU_DateFormat_06 =  @"MM-dd HH:mm";

NSString * const  YU_DateFormat01 =  @"yyyy.MM.dd HH:mm.ss.SSS";
NSString * const  YU_DateFormat02 =  @"yyyy.MM.dd HH:mm.ss";
NSString * const  YU_DateFormat03 =  @"yyyy.MM.dd HH:mm";
NSString * const  YU_DateFormat04 =  @"yyyy.MM.dd HH";
NSString * const  YU_DateFormat05 =  @"yyyy.MM.dd";

NSString * const  YU_DateFormat一 =  @"yyyy年MM月dd日HH点mm分";
NSString * const  YU_DateFormat二 =  @"MM月dd日HH点mm分";


#define kOneDayInterval (24 * 60 * 60 )
#define k7DayInterval (7 * kOneDayInterval)

@implementation NSDate (Lwt)


-(int)day
{
    return [NSCalendar getDayWithDate:self];
}


-(int)month
{
    return [NSCalendar getMonthWithDate:self];
}

-(int)year
{
    return [NSCalendar getYearWithDate:self];
}


-(int)nextDay
{
    NSDate *date = [self dateByAddingTimeInterval:kOneDayInterval];
    return date.day;
}

-(int)preDay
{
    NSDate *date = [self dateByAddingTimeInterval:-kOneDayInterval];
    return date.day;
    
}

-(NSDate*)nextWeek
{
    return [self dateByAddingTimeInterval:7 * kOneDayInterval];
}

-(NSDate*)preWeek
{
    return [self dateByAddingTimeInterval:-7 * kOneDayInterval];
}


-(NSDate*)nextDate
{
    return [self dateByAddingTimeInterval:kOneDayInterval];
}

-(NSDate*)preDate
{
    return [self dateByAddingTimeInterval:-kOneDayInterval];
}

-(NSDate*)weekMonday
{
    int weekDay = [NSCalendar getWeekdayWithDate:self];
    int offset = 0;
    if (weekDay == 1) {
        offset = -6;
    } else {
        offset = 2- weekDay;
    }
    NSDate *date = [self dateByAddingTimeInterval:(kOneDayInterval * offset)];
    return date;
}

-(NSDate*)natualWeekFirstDay
{
    int weekDay = [NSCalendar getWeekdayWithDate:self];
    int offset = weekDay - 1;
    
    NSDate *date = [self dateByAddingTimeInterval:-(kOneDayInterval * offset)];
    return date;
}

-(NSDate*)monthFirstDay
{
    NSDateComponents *comp = [NSCalendar dateComponentsWithDate:self];
    comp.day = 1;
    
    
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comp];
    return date.dayStart;
}

-(NSDate*)nextMonth
{
    NSDateComponents *comp = [NSCalendar dateComponentsWithDate:self];
    comp.month = (comp.month + 1) % 13 + (comp.month + 1) / 13;
    comp.day = 1;
    if (comp.month == 1) {
        comp.year++;
    }
    return [[NSCalendar currentCalendar] dateFromComponents:comp];
    
}

-(NSDate*)preMonth
{
    NSDateComponents *comp = [NSCalendar dateComponentsWithDate:self];
    int month = (comp.month - 1) % 13;
    int year = (int)comp.year;
    if (month == 0) {
        month = 12;
        year--;
    }
    comp.day = 1;
    comp.year = year;
    comp.month = month;
    return [[NSCalendar currentCalendar] dateFromComponents:comp];
}

-(NSDate*)dayStart
{
    NSDateComponents *comp = [NSCalendar dateComponentsWithDate:self];
    comp.hour = 0;
    comp.minute = 0;
    comp.second = 0;
    return [[NSCalendar currentCalendar] dateFromComponents:comp];
}

-(NSDate*)dayEnd
{
    NSDateComponents *comp = [NSCalendar dateComponentsWithDate:self];
    comp.hour = 23;
    comp.minute = 59;
    comp.second = 59;
    return [[NSCalendar currentCalendar] dateFromComponents:comp];
}

-(NSDate*)nextYearFirstDay
{
    NSDateComponents *comp = [NSCalendar dateComponentsWithDate:self];
    comp.year++;
    comp.month = comp.day = 1;
    comp.hour = comp.second = comp.minute = 0;
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comp];
    return date;
}

-(NSDate*)preYearFirstDay
{
    NSDateComponents *comp = [NSCalendar dateComponentsWithDate:self];
    comp.year--;
    comp.month = comp.day = 1;
    comp.hour = comp.second = comp.minute = 0;
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comp];
    return date.dayStart;
}

-(NSDate*)yearEnd
{
    NSDateComponents *comp = [NSCalendar dateComponentsWithDate:self];
    comp.month = 12;
    comp.day = 31;
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comp];
    return date.dayEnd;
}

-(NSDate*)yearFirst
{
    NSDateComponents *comp = [NSCalendar dateComponentsWithDate:self];
    comp.month = 1;
    comp.day = 1;
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comp];
    return date.dayStart;
}

-(NSDate*)yearLastWeekMonday
{
    NSDate *date = self.yearEnd;
    int week = [NSCalendar getWeekdayWithDate:date];
    date = [date dateByAddingTimeInterval:-(week - 1) * kOneDayInterval];
    return date.dayStart;
}

-(NSDate*)weekEnd
{
    int week = [NSCalendar getWeekOfYearWithDate:self];
    if (week == 1 && self.month == 12) {
        return self.yearEnd;
    } else {
        return self.natualWeekFirstDay.nextWeek.preDate.dayEnd;
    }
}

-(NSString*)dateStringFormat:(NSString*)ft
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:ft];
    
    NSString *destDateString = [dateFormatter stringFromDate:self];
    return  destDateString;
}

-(NSString*)dateStr{
    return [self dateStringFormat:@"yyyy-MM-dd HH:mm:ss"];
}



//大于date  返回yes
-(BOOL)compareDate:(NSDate*)date{
    return [[self earlierDate:date] isEqualToDate:date];
}

-(BOOL)comparewithDate:(NSDate *)date{
    NSComparisonResult result = [self compare:date];
    BOOL isbig = NO;
    if (result==NSOrderedDescending) {//大于
        isbig = YES;
    }
    return isbig;
}


-(BOOL)isEqualDay:(NSDate*)date{
    return ([NSCalendar getYearWithDate:self] == [NSCalendar getYearWithDate:date] &&
            [NSCalendar getMonthWithDate:self] == [NSCalendar getMonthWithDate:date] &&
            [NSCalendar getDayWithDate:self] == [NSCalendar getDayWithDate:date])
    ;
}

-(BOOL)isEqualWeek:(NSDate*)date{
    BOOL isEqual =  ([NSCalendar getYearWithDate:self] == [NSCalendar getYearWithDate:date] &&
                     [NSCalendar getMonthWithDate:self] == [NSCalendar getMonthWithDate:date] && [NSCalendar getWeekOfYearWithDate2:self]== [NSCalendar getWeekOfYearWithDate2:date]);
    return isEqual;
    
}

-(BOOL)isEqualMOnth:(NSDate*)date{
    return ([NSCalendar getYearWithDate:self] == [NSCalendar getYearWithDate:date] &&
            [NSCalendar getMonthWithDate:self] == [NSCalendar getMonthWithDate:date])
    ;
}

-(BOOL)isEqualYear:(NSDate*)date{
    return [NSCalendar getYearWithDate:self] == [NSCalendar getYearWithDate:date];
}


-(NSDate *)CurrentDate:(NSString *)pattern{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [dateFormatter setDateFormat:pattern];
    NSString *currentDateStr = [dateFormatter stringFromDate:self];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:YU_DefaultDateFormat];
    return [dateFormatter dateFromString: currentDateStr];
}

+(NSString *)currentDate:(NSString*)pattern{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [dateFormatter setDateFormat:pattern];
    return [dateFormatter stringFromDate:[NSDate date]];
}

+(NSString *)currentDate{
    return [NSDate currentDate:@"YYYY-MM-dd HH:mm:ss"];
}

+ (NSString *)dateFromeMillisecond:(NSString *)millisecond
{
    
    long long time = [millisecond longLongValue];
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:time/1000.0];
    NSDateFormatter *fomater = [[NSDateFormatter alloc] init];
    fomater.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    
    return [fomater stringFromDate:date];
    
}


+ (NSString *)getHoursAndMunit:(NSString *)toTime
{
    if ([toTime floatValue]<=0) return @"00小时00分钟";
    
    long long time = [toTime longLongValue];
    NSDate *dateS = [[NSDate alloc] initWithTimeIntervalSince1970:time/1000.0];
    NSDate *currentDate = [NSDate date];
    long sec = [currentDate timeIntervalSinceDate:dateS];
    
    NSInteger hour =   (NSInteger)sec /3600;
    NSInteger min = ((NSInteger)sec % 3600) /60;
    //    NSInteger seconds = ((((NSInteger)sec % (25*3600)) % 3600) % 60) ;
    
    return [NSString stringWithFormat:@"%02d小时%02d分钟",hour,min];
}

+ (NSString * )timeDiff:(NSString *)fromTime toTime:(NSString *)toTime
{
    double sec = 0.0;
    
    
    NSDateFormatter *formatters = [[NSDateFormatter alloc]init];
    [formatters setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDate *dateS = [formatters dateFromString:fromTime];
    NSDate *dateE = [formatters dateFromString:toTime];
    
    sec = [dateE timeIntervalSinceDate:dateS ];
    
    
    NSInteger hour =   (NSInteger)sec /3600;
    NSInteger min = ((NSInteger)sec % 3600) /60;
//    NSInteger seconds = ((((NSInteger)sec % (25*3600)) % 3600) % 60) ;

    
    
    
    return [NSString stringWithFormat:@"%02d小时%02d分钟",hour,min];
}




@end
