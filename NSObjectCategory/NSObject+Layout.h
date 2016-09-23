//
//  NSObject+Layout.h
//  App
//
//  Created by 李文韬 on 16/1/15.
//  Copyright © 2016年 com.wentao. All rights reserved.
//

#import <Foundation/Foundation.h>

static  NSInteger const TabbarH = 49; //工具栏高度

static  NSInteger const NavbarH = 64; //导航栏高度


static  NSInteger const MyMargin = 10;

#define BaseBg_Color RGBColor(244, 244, 244, 1) //基础背景颜色

#define NavBar_Color RGBColor(183, 78, 147, 1) //导航栏颜色


#define GETSCALE_X  [NSObject getScaleX] //比例系数
#define GETSCALE_Y  [NSObject getScaleY]



//字体大小
#define TextFont_BIG_MORE [UIFont systemFontOfSize:19]
#define TextFont_BIG  [UIFont systemFontOfSize:17]
#define TextFont_MEDIUM [UIFont systemFontOfSize:15]
#define TextFont_SMALL [UIFont systemFontOfSize:13]
#define TextFont_SMALL_MORE [UIFont systemFontOfSize:11]


@interface NSObject (Layout)


//获得屏幕比例   以iPhone6为基准
+ (CGFloat)getScaleX;

+ (CGFloat)getScaleY;



@end
