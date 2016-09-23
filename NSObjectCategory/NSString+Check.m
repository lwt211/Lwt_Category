//
//  NSString+Check.m
//  App
//
//  Created by 李文韬 on 16/1/14.
//  Copyright © 2016年 com.wentao. All rights reserved.
//

#import "NSString+Check.h"

@implementation NSString (Check)


-(BOOL)checkPhoneLength{
    if ([self length]>=11 && [self length]<=14) {
        return YES;
    }
    return NO;
}

-(BOOL)isPhoneNo
{
    BOOL ret = FALSE;
    NSString *regex =  @"^(\\+86|(\\(\\+86\\)))?(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(17[0-9]{1}))+[0-9]{8})$";
    
    if (IsSafeString(self)) {
        NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        ret = [pred evaluateWithObject:self];
    }
    return  ret;
}

-(BOOL)isPwd
{
    return  IsSafeString(self) && self.length >= 6 && self.length <= 16 ;
}


- (BOOL)isEmail{
    
    NSString *regex = @"[a-zA-Z_]{1,}[0-9]{0,}@(([a-zA-z0-9]-*){1,}\\.){1,3}[a-zA-z\\-]{1,}" ;
    BOOL ret = FALSE;
    if (IsSafeString(self)) {
        NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        ret = [pred evaluateWithObject:self];
    }
    return  ret;

}

//有非法字符
-(BOOL)isIncludeSpecialCharact{
    //***需要过滤的特殊字符：~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€。
    NSRange urgentRange = [self rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€"]];
    if (urgentRange.location == NSNotFound)
    {
        return NO;
    }
    return YES;
}


-(BOOL)isDecimal //小数
{
    
    BOOL ret = FALSE;
    
    NSString *regex = @"^(([0-9]+\\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\\.[0-9]+)|([0-9]*[1-9][0-9]*))$";//@"^\\d{1}$|^\\d{1}$.\\d{1}$";//@"^\\d{1,}$|^\\d{1,}.\\d{2,2}$"; //@"^(0|[1-9]/d*)/.(/d+)$";
    if (IsSafeString(self)) {
        NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        ret = [pred evaluateWithObject:self];
    }
    return ret;
}

//车牌号验证
- (BOOL)isCarNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:self];
}

//身份证号
- (BOOL)isIdentityCard
{
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}

//版本对比
- (BOOL)isNewVisrsions
{
    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *str = [infoDic objectForKey:@"CFBundleShortVersionString"];
    NSArray *arr = [str componentsSeparatedByString:@"."];
    NSString *str1 = [arr componentsJoinedByString:@""];
    NSInteger currentVersrion = [str1 integerValue];
    
    NSLog(@"%@ %zd",str,currentVersrion);
    
    NSArray *currentVersionArr = [self componentsSeparatedByString:@"."];
    NSString *versrionStr = [currentVersionArr componentsJoinedByString:@""];
    NSInteger newVersrion = [versrionStr integerValue];
    
    NSLog(@"%@ %zd",versrionStr,newVersrion);
    
    return newVersrion>currentVersrion;
}

- (CGSize)lableSizeOfFont:(UIFont *)font constraint:(CGSize)constraint
{
    CGSize size ;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    size = [self boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    
    return  size;
}

@end
