//
//  UIView+Animation.h
//  D3View
//
//  Created by 李文韬 on 16/4/5.
//  Copyright © 2016年 mozhenhau. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DEFAULT_DURATION 0.25
typedef void(^CompletionBlock)();


@interface UIView (Animation)

@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat bottom;

@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;

@property(nonatomic) CGFloat centerX;
@property(nonatomic) CGFloat centerY;
@property(nonatomic) CGPoint origin;
@property(nonatomic) CGSize size;


#pragma mark 动画基础
/**
 *  添加动画效果
 * 加入动画效果
 
 - parameter type:
 fade     //交叉淡化过渡(不支持过渡方向)
 push     //新视图把旧视图推出去
 moveIn   //新视图移到旧视图上面
 reveal   //将旧视图移开,显示下面的新视图
 cube     //立方体翻滚效果
 oglFlip  //上下左右翻转效果
 suckEffect   //收缩效果，如一块布被抽走(不支持过渡方向)
 rippleEffect //滴水效果(不支持过渡方向)
 pageCurl     //向上翻页效果
 pageUnCurl   //向下翻页效果
 cameraIrisHollowOpen  //相机镜头打开效果(不支持过渡方向)
 cameraIrisHollowClose //相机镜头关上效果(不支持过渡方向)
 
 
 - parameter subType:
 kCATransitionFromRight
 kCATransitionFromLeft
 kCATransitionFromTop
 kCATransitionFromBottom
 
 
 - parameter duration: 动画持续时间
 */
-(void)Animation:(NSString*)type subType:(NSString*)subType duration:(NSTimeInterval)duration;


-(void)Animation:(NSTimeInterval)duration transition:(UIViewAnimationTransition)transition forView:(UIView*)view completion:(CompletionBlock)completion;

-(void)removeAnimate;

-(CGFloat)degressToRadians:(CGFloat)angle;

/**
 *  设置x的位置，有动画效果
 *
 */
-(void)setX:(CGFloat)x completion:(CompletionBlock)completion;

-(void)setX:(CGFloat)x duration:(NSTimeInterval)duration completion:(CompletionBlock)completion;


/**
 *  设置y的位置
 */
-(void)setY:(CGFloat)y completion:(CompletionBlock)completion;

-(void)setY:(CGFloat)y duration:(NSTimeInterval)duration completion:(CompletionBlock)completion;

/**
 *  旋转角度
 *  @param angle      角度， 为-1的时候一直转.  0~180
 *
 */
-(void)setRotate:(CGFloat)angle completion:(CompletionBlock)completion;

-(void)setRotate:(CGFloat)angle duration:(NSTimeInterval)duration completion:(CompletionBlock)completion;


/**
 *  设置point
 *
 */
-(void)setPoint:(CGPoint)point completion:(CompletionBlock)completion;

-(void)setPoint:(CGPoint)point duration:(NSTimeInterval)duration completion:(CompletionBlock)completion;


//在现在位置基础上移动
-(void)moveX:(CGFloat)x completion:(CompletionBlock)completion;

-(void)moveX:(CGFloat)x duration:(NSTimeInterval)duration completion:(CompletionBlock)completion;


-(void)moveY:(CGFloat)y completion:(CompletionBlock)completion;

-(void)moveY:(CGFloat)y duration:(NSTimeInterval)duration completion:(CompletionBlock)completion;

#pragma 以下是动画
/**
 *  左右摇动
 */
-(void)shake:(CGFloat)range duration:(NSTimeInterval)duration completion:(CompletionBlock)completion;

-(void)shake;


/**
 *  上下摇动
 */
-(void)bounce:(CGFloat)range duration:(NSTimeInterval)duration completion:(CompletionBlock)completion;

-(void)bounce;


/**
 *  心跳
 */
-(void)heartbeat:(CGFloat)range duration:(NSTimeInterval)duration completion:(CompletionBlock)completion;

-(void)heartbeat;


/**
 *  摇摆
 */
-(void)swing:(CGFloat)range duration:(NSTimeInterval)duration completion:(CompletionBlock)completion;

-(void)swing;


/**
 *  整体放大缩小
 */
-(void)scale:(CGFloat)scale duration:(NSTimeInterval)duration completion:(CompletionBlock)completion;


-(void)scale:(CGFloat)scale;


-(void)scaleX:(CGFloat)scale duration:(NSTimeInterval)duration completion:(CompletionBlock)completion;


-(void)scaleX:(CGFloat)scale;


-(void)scaleY:(CGFloat)scale duration:(NSTimeInterval)duration completion:(CompletionBlock)completion;

-(void)scaleY:(CGFloat)scale;


/**
 *  掉落
 */
-(void)drop:(NSTimeInterval)duration completion:(CompletionBlock)completion;

-(void)drop;



/**
 *  翻转
 */
-(void)flip:(NSTimeInterval)duration completion:(CompletionBlock)completion;

-(void)flip;



/**
 *  翻页
 */
-(void)pageing:(NSTimeInterval)duration completion:(CompletionBlock)completion;

-(void)pageing;


/**
 *  闪亮，呼吸灯
 */
-(void)blink:(NSTimeInterval)duration;


-(void)blink;


/**
 *  渐隐
 */
-(void)fadeOut:(NSTimeInterval)duration completion:(CompletionBlock)completion;

-(void)fadeOut;

/**
 *  渐现
 */
-(void)fadeIn:(NSTimeInterval)duration completion:(CompletionBlock)completion;

-(void)fadeIn;


@end
