//
//  UIAlertController+Lwt.h
//  App
//
//  Created by 李文韬 on 16/1/14.
//  Copyright © 2016年 com.wentao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Lwt)



+ (void)defaultAlert:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void (^)(UIAlertAction *action))cancelBlock submitTitle:(NSString *)submitTitle submitBlock:(void (^)(UIAlertAction *action))submitBlock completedBlock:(void (^)(void))completedBlock;

+ (void)defaultAlert:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void (^)(UIAlertAction * ))cancelBlock completedBlock:(void (^)(void))completedBlock;




@end
