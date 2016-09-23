//
//  UIImage+Lwt.h
//  App
//
//  Created by 李文韬 on 16/1/14.
//  Copyright © 2016年 com.wentao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (Lwt)

// 缩放图片 不剪切
- (UIImage *)resizeImageWithNewSize:(CGSize)newSize;

//剪切图片
- (UIImage *)croppedImage:(CGRect)rect;

//等比，居中剪切
- (UIImage *)croppedCenterImage:(CGSize)size;

//顺时针多少度 弧度 0 ~ 2M_PI
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;

//顺时针多少度 度 0 ~ 360
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

//获取该图片的大概颜色
-(UIColor*)mostColor;

-(UIImage *)imageWithTintColor:(UIColor *)tintColor;

/**
 调整大小
 */
- (UIImage *)resizedImageWithBounds:(CGSize)bounds;

/**
 根据视图返回图片
 */
+(UIImage *)imageWithUIView:(UIView*) view;

/**
 根据颜色返回图片
 */

+(UIImage *)imageWithColor:(UIColor*)color size:(CGSize)size;


@end
