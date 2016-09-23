//
//  NSObject+Delay.m
//  App
//
//  Created by 李文韬 on 16/1/14.
//  Copyright © 2016年 com.wentao. All rights reserved.
//

#import "NSObject+Delay.h"

@implementation NSObject (Delay)

+ (void)afterBlock:(dispatch_block_t)block after:(float)time
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}

+ (void)performBlock:(void (^)(void))block
          afterDelay:(NSTimeInterval)delay
{
    block = [block copy];
    [self performSelector:@selector(fireBlockAfterDelay:)
               withObject:block
               afterDelay:delay];
}

+ (void)fireBlockAfterDelay:(void (^)(void))block {
    block();
}

+ (void)performAfterDelay:(float)delay thisBlock:(void (^)(BOOL finished))completion{
    
    [UIView animateWithDuration:delay
                     animations: ^{
                         
                     }completion:^(BOOL finished) {
                         
                         if (completion) {
                             completion(finished);
                         }
                     }];
}

+ (void)performBlockInBackground:(NSObjectPerformBlock)performBlock completion:(NSObjectPerformBlock)completionBlock userObject:(id)userObject
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        performBlock(userObject);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionBlock) {
                completionBlock(userObject);
            }
        });
    });
}

@end
