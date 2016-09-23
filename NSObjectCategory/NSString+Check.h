//
//  NSString+Check.h
//  App
//
//  Created by 李文韬 on 16/1/14.
//  Copyright © 2016年 com.wentao. All rights reserved.
//

#import <Foundation/Foundation.h>

//正则表达式


@interface NSString (Check)

-(BOOL)checkPhoneLength;//电话长度

-(BOOL)isPhoneNo; //是否为电话号码

-(BOOL)isEmail;//是否是邮箱

-(BOOL)isPwd; //密码确认

-(BOOL)isDecimal;//带小数点的数字

//非法字符
-(BOOL)isIncludeSpecialCharact;

//车牌号验证
- (BOOL)isCarNo;

//身份证
- (BOOL)isIdentityCard;

//版本对比
- (BOOL)isNewVisrsions;


//根据文字获得大小

- (CGSize)lableSizeOfFont:(UIFont *)font constraint:(CGSize)constraint;

@end
