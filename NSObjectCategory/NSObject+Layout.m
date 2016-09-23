//
//  NSObject+Layout.m
//  App
//
//  Created by 李文韬 on 16/1/15.
//  Copyright © 2016年 com.wentao. All rights reserved.
//

#import "NSObject+Layout.h"

@implementation NSObject (Layout)

+ (CGFloat)getScaleX
{

    if (IS_IPhone6_Plus)
    {
       return 414/375.f;
    }
    
    if (IS_IPhone6)
    {
        return 1.0f;
    }
    
     return 320/375.f;
    
}

+ (CGFloat)getScaleY
{
    
    if (IS_IPhone6_Plus)
    {
       return 736/667.f;
    }
    
    if (IS_IPhone6)
    {
        return 1.0f;
    }

    return 568/667.f;
}



@end
