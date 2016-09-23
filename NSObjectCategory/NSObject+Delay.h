//
//  NSObject+Delay.h
//  App
//
//  Created by 李文韬 on 16/1/14.
//  Copyright © 2016年 com.wentao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^NSObjectPerformBlock)(id userObject);

@interface NSObject (Delay)

+ (void)afterBlock:(dispatch_block_t)block after:(float)time;


+ (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;


+ (void)performAfterDelay:(float)delay thisBlock:(void (^)(BOOL finished))completion;


+ (void)performBlockInBackground:(NSObjectPerformBlock)performBlock completion:(NSObjectPerformBlock)completionBlock userObject:(id)userObject;



@end
