//
//  NSObject+Base64.h
//  App
//
//  Created by 李文韬 on 16/1/14.
//  Copyright © 2016年 com.wentao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Base64)

/**
 *  将UTF-8文字编码为base64的文字
 *
 *  @param oldStr 需要进行编码的文字
 *
 *  @return 编码后的文字
 */
+ (NSString *)encodeStringBase64WithString:(NSString *)oldStr;

/**
 *  将JPEG图片编码为base64的文字(当然是通过data转的)
 *
 *  @param image 需要编码的图片
 *
 *  @return 编码后的文字
 */
+ (NSString *)encodeStringBase64WithJPEGImage:(UIImage *)image;

/**
 *  将PNG图片编码为base64的文字(当然是通过data转的)
 *
 *  @param image 需要编码的图片
 *
 *  @return 编码后的文字
 */
+ (NSString *)encodeStringBase64WithPNGImage:(UIImage *)image;

//=====================================华丽的分割线=====================================//



/**
 *  将base64的文字解码为UTF-8的文字
 *
 *  @param oldStr 需要解码的文字
 *
 *  @return 解码后的文字
 */
+ (NSString *)decodeStringBase64WithString:(NSString *)oldStr;

/**
 *  将base64的文字解码为图片
 *
 *  @param str 需要解码的文字
 *
 *  @return 解码后的图片
 */
+ (UIImage *)decodeStringBase64WithImage:(NSString *)str;


@end
