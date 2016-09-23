//
//  LuckPickViiew.h
//  RongWinLottery
//
//  Created by rykj-ios1 on 15/6/11.
//  Copyright (c) 2015年 rykj-ios1. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, PickType)
{
    PickOther = 0, //其他
    PickDateTime_Time, //时间选择器
    PickDateTime_Date, //日期选择器
    PickDateTime_DateAndTime, //日期和时间选择器
   
};


@protocol Lwt_PickViewDelegate <NSObject>

- (void)pickViewdidSelectWithRows:(NSArray *)selecRows titles:(NSArray *)selecTitles contentType:(NSInteger)contentType;


@end



@interface Lwt_PickView : UIView <UIPickerViewDelegate,UIPickerViewDataSource>


@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,assign) PickType pickType;
@property (nonatomic,strong) UIFont *sureFont; //确定键字体
@property (nonatomic,strong) UIColor *sureTintColor; //确定键颜色
@property (nonatomic,strong) UIColor *backColor; //背景颜色
@property (nonatomic,strong) UIFont *font; //内容字体
@property (nonatomic,strong) UIColor *textColor; //内容字体颜色


@property (nonatomic,readwrite) NSInteger contentType;




@property (nonatomic,weak) id <Lwt_PickViewDelegate>delegate;

- (void)showPickView;//弹出选择器

/***时间选择器*/
- (void)setDatePickViewDate:(NSString *)str; //起始停留时间

- (void)setCurrentDate; //设置起始时间为当前时间


@end
