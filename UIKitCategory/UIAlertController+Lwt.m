

//
//  UIAlertController+Lwt.m
//  App
//
//  Created by 李文韬 on 16/1/14.
//  Copyright © 2016年 com.wentao. All rights reserved.
//

#import "UIAlertController+Lwt.h"

@implementation UIAlertController (Lwt)


+ (void)defaultAlert:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void (^)(UIAlertAction *action))cancelBlock submitTitle:(NSString *)submitTitle submitBlock:(void (^)(UIAlertAction *action))submitBlock completedBlock:(void (^)(void))completedBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelBlock];
    
    UIAlertAction *submit = [UIAlertAction actionWithTitle:submitTitle style:UIAlertActionStyleDestructive handler:submitBlock];
    
    // 先加入的在左边
    [alertController addAction:cancel];
    [alertController addAction:submit];
    
    [[self lastPresentedViewController] presentViewController:alertController animated:YES completion:completedBlock];
}


+ (void)defaultAlert:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void (^)(UIAlertAction * ))cancelBlock completedBlock:(void (^)(void))completedBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelBlock];
    
    [alertController addAction:cancel];
    
    [[self lastPresentedViewController] presentViewController:alertController animated:YES completion:completedBlock];
    
}

+ (UIViewController*)lastPresentedViewController
{
    UIViewController *presentedViewController = [self getChildPresentViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
    return presentedViewController;
}

+ (UIViewController*)getChildPresentViewController:(UIViewController *)vc
{
    if (!vc.presentedViewController) {
        return vc;
    } else {
        return [self getChildPresentViewController:vc.presentedViewController];
    }
}

@end
