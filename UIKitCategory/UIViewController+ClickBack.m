//
//  UIViewController+ClickBack.m
//  App
//
//  Created by 李文韬 on 16/6/12.
//  Copyright © 2016年 com.wentao. All rights reserved.
//

#import "UIViewController+ClickBack.h"



@implementation UIViewController (ClickBack)




@end



@implementation UINavigationController (ClickBack)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
  
    
    if([self.viewControllers count] < [navigationBar.items count]) {
        
        return YES;
        
    }
    
    BOOL shouldPop = YES;
    UIViewController* vc = [self topViewController];
    if([vc respondsToSelector:@selector(clickBackItem)]) {
        
        shouldPop = [vc clickBackItem];
        
    }
    
    if(shouldPop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [vc.navigationController popViewControllerAnimated:YES];
        });
    } else {
        for(UIView *subview in [navigationBar subviews]) {
            if(0. < subview.alpha && subview.alpha < 1.)
            {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
    }
    return NO;
}


@end
