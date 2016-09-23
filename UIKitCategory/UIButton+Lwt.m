//
//  UIButton+Lwt.m
//  shuangtu
//
//  Created by 李文韬 on 16/9/23.
//  Copyright © 2016年 TD_. All rights reserved.
//

#import "UIButton+Lwt.h"

@implementation UIButton (Lwt)
    
- (void)sd_setBackgroundColor:(UIColor *)backgroundColor
{
    [self setBackgroundImage:[self imageWithColor:backgroundColor size:self.size] forState:UIControlStateNormal];
    [self sd_setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.3] forState:UIControlStateHighlighted];
}
    
- (void)sd_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
      [self setBackgroundImage:[self imageWithColor:backgroundColor size:self.size] forState:state];
}

    
- (UIImage *)imageWithColor:(UIColor*)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context,
                                   
                                   color.CGColor);
    
    CGContextFillRect(context, rect);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}


@end
