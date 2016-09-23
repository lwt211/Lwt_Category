//
//  UIView+Animation.m
//  D3View
//
//  Created by 李文韬 on 16/4/5.
//  Copyright © 2016年 mozhenhau. All rights reserved.
//

#import "UIView+Animation.h"



@implementation UIView (Animation)

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}



#pragma mark 动画基础
-(void)Animation:(NSString*)type subType:(NSString*)subType duration:(NSTimeInterval)duration{
    CATransition *action = [[CATransition alloc]init];
    action.type = type;
    action.subtype = subType;
    action.duration = duration;
    [self.layer addAnimation:action forKey:@"animation"];
}


-(void)Animation:(NSTimeInterval)duration transition:(UIViewAnimationTransition)transition forView:(UIView*)view completion:(CompletionBlock)completion{
    [UIView animateWithDuration:duration animations:^{
        [UIView setAnimationTransition:transition forView:view cache:true];
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

-(void)removeAnimate{
    [self.layer removeAllAnimations];
}

-(CGFloat)degressToRadians:(CGFloat)angle{
    return angle*M_PI/180;
}

/**
 *  设置x的位置，有动画效果
 *
 */
-(void)setX:(CGFloat)x completion:(CompletionBlock)completion{
    [self setX:x duration:DEFAULT_DURATION completion:completion];
}

-(void)setX:(CGFloat)x duration:(NSTimeInterval)duration completion:(CompletionBlock)completion{
    [UIView animateWithDuration:duration animations:^{
        [self setLeft:x];
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}


/**
 *  设置y的位置
 */
-(void)setY:(CGFloat)y completion:(CompletionBlock)completion{
    [self setY:y duration:DEFAULT_DURATION completion:completion];
}

-(void)setY:(CGFloat)y duration:(NSTimeInterval)duration completion:(CompletionBlock)completion{
    [UIView animateWithDuration:duration animations:^{
        [self setTop:y];
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

/**
 *  旋转角度
 *  @param angle      角度， 为-1的时候一直转.  0~180
 *
 */
-(void)setRotate:(CGFloat)angle completion:(CompletionBlock)completion{
    [self setRotate:angle duration:DEFAULT_DURATION completion:completion];
}

-(void)setRotate:(CGFloat)angle duration:(NSTimeInterval)duration completion:(CompletionBlock)completion{
    UIViewAnimationOptions options = UIViewAnimationOptionCurveLinear;
    CGFloat angle1 = angle;
    if (angle1 == -1) {
        angle1 = 180;
        options = UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveLinear;
    }
    
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        self.transform = CGAffineTransformMakeRotation([self degressToRadians:angle1]);
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
    
}


/**
 *  设置point
 *
 */
-(void)setPoint:(CGPoint)point completion:(CompletionBlock)completion{
    [self setPoint:point duration:DEFAULT_DURATION completion:completion];
}

-(void)setPoint:(CGPoint)point duration:(NSTimeInterval)duration completion:(CompletionBlock)completion{
    [UIView animateWithDuration:duration animations:^{
        self.origin = point;
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}


//在现在位置基础上移动
-(void)moveX:(CGFloat)x completion:(CompletionBlock)completion{
    [self moveX:x duration:DEFAULT_DURATION completion:completion];
}

-(void)moveX:(CGFloat)x duration:(NSTimeInterval)duration completion:(CompletionBlock)completion{
    [self setX:self.left + x duration:DEFAULT_DURATION completion:completion];
}


-(void)moveY:(CGFloat)y completion:(CompletionBlock)completion{
    [self moveY:y duration:DEFAULT_DURATION completion:completion];
}

-(void)moveY:(CGFloat)y duration:(NSTimeInterval)duration completion:(CompletionBlock)completion{
    [self setY:self.top + y duration:duration completion:completion];
}

#pragma 以下是动画
/**
 *  左右摇动
 */
-(void)shake:(CGFloat)range duration:(NSTimeInterval)duration completion:(CompletionBlock)completion{
    [self moveX:-range duration:duration completion:^{
        [self moveX:range*2 duration:duration completion:^{
            [self moveX:-range*2 duration:duration completion:^{
                [self moveX:range duration:duration completion:^{
                    if (completion) {
                        completion();
                    }
                }];
            }];
        }];
    }];
}

-(void)shake{
    [self shake:10 duration:DEFAULT_DURATION completion:nil];
}


/**
 *  上下摇动
 */
-(void)bounce:(CGFloat)range duration:(NSTimeInterval)duration completion:(CompletionBlock)completion{
    [self moveY:-range duration:duration completion:^{
        [self moveY:range duration:duration completion:^{
            [self moveY:-range/2 duration:duration completion:^{
                [self moveY:range/2 duration:duration completion:^{
                    if (completion) {
                        completion();
                    }
                }];
            }];
        }];
    }];
}

-(void)bounce{
    [self bounce:10 duration:DEFAULT_DURATION completion:nil];
}


/**
 *  心跳
 */
-(void)heartbeat:(CGFloat)range duration:(NSTimeInterval)duration completion:(CompletionBlock)completion{
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformMakeScale(range, range);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration delay:0.1 options:UIViewAnimationOptionLayoutSubviews|UIViewAnimationCurveEaseOut animations:^{
            self.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            if (completion) {
                completion();
            }
        }];
    }];
    
}

-(void)heartbeat{
    [self heartbeat:1.2 duration:0.5 completion:nil];
}


/**
 *  摇摆
 */
-(void)swing:(CGFloat)range duration:(NSTimeInterval)duration completion:(CompletionBlock)completion{
    
    __weak UIView *self_view = self;
    
    
    [self setRotate:range duration:duration completion:^{
        [self_view setRotate:-range duration:duration completion:^{
            [self_view setRotate:range/2 duration:duration completion:^{
                [self_view setRotate:0 duration:duration completion:^{
                    if (completion) {
                        completion();
                    }
                }];
            }];
        }];
    }];
}

-(void)swing{
    [self swing:15 duration:DEFAULT_DURATION completion:nil];
}


/**
 *  整体放大缩小
 */
-(void)scale:(CGFloat)scale duration:(NSTimeInterval)duration completion:(CompletionBlock)completion{
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformMakeScale(scale, scale);
    }];
}

-(void)scale:(CGFloat)scale{
    [self scale:scale duration:DEFAULT_DURATION completion:nil];
}



-(void)scaleX:(CGFloat)scale duration:(NSTimeInterval)duration completion:(CompletionBlock)completion{
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformMakeScale(scale, 1);
    }];
}

-(void)scaleX:(CGFloat)scale{
    [self scaleX:scale duration:DEFAULT_DURATION completion:nil];
}


-(void)scaleY:(CGFloat)scale duration:(NSTimeInterval)duration completion:(CompletionBlock)completion{
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformMakeScale(1, scale);
    }];
}


-(void)scaleY:(CGFloat)scale{
    [self scaleY:scale duration:DEFAULT_DURATION completion:nil];
}


/**
 *  掉落
 */
-(void)drop:(NSTimeInterval)duration completion:(CompletionBlock)completion{
    CGPoint point = self.frame.origin;
    self.layer.anchorPoint = CGPointMake(0, 0);
    self.center = point;
    
    
    __weak UIView *self_view = self;
    
    [self setRotate:80 duration:duration completion:^{
        [self_view setRotate:70 duration:duration completion:^{
            [self_view setRotate:80 duration:duration completion:^{
                [self_view setRotate:70 duration:duration completion:^{
                    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                        [self_view setTop:[UIScreen mainScreen].bounds.size.height];
                    } completion:^(BOOL finished) {
                        if (completion) {
                            completion();
                        }
                    }];
                }];
            }];
        }];
    }];
}

-(void)drop{
    [self drop:0.5 completion:nil];
}



/**
 *  翻转
 */
-(void)flip:(NSTimeInterval)duration completion:(CompletionBlock)completion{
    [self Animation:duration transition:UIViewAnimationTransitionFlipFromLeft forView:self completion:completion];
}

-(void)flip{
    [self flip:1.0 completion:nil];
}



/**
 *  翻页
 */
-(void)pageing:(NSTimeInterval)duration completion:(CompletionBlock)completion{
    [self Animation:duration transition:UIViewAnimationTransitionCurlUp forView:self completion:completion];
}

-(void)pageing{
    [self pageing:1.0 completion:nil];
}


/**
 *  闪亮，呼吸灯
 */
-(void)blink:(NSTimeInterval)duration{
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)blink{
    [self blink:0.5];
}

/**
 *  渐隐
 */
-(void)fadeOut:(NSTimeInterval)duration completion:(CompletionBlock)completion{
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

-(void)fadeOut{
    [self fadeOut:0.5 completion:nil];
}


/**
 *  渐现
 */
-(void)fadeIn:(NSTimeInterval)duration completion:(CompletionBlock)completion{
    self.hidden = NO;
    self.alpha = 0;
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

-(void)fadeIn{
    [self fadeIn:0.5 completion:nil];
}


@end
