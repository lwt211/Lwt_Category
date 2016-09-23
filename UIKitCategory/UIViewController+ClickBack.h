//
//  UIViewController+ClickBack.h
//  App
//
//  Created by 李文韬 on 16/6/12.
//  Copyright © 2016年 com.wentao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClickBackItemDelegate <NSObject>

@optional

- (BOOL)clickBackItem;


@end


@interface UIViewController (ClickBack)<ClickBackItemDelegate>


@end
