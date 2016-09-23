//
//  NSData+Lwt.m
//  App
//
//  Created by 李文韬 on 16/1/14.
//  Copyright © 2016年 com.wentao. All rights reserved.
//

#import "NSData+Lwt.h"

@implementation NSData (Lwt)

- (NSArray *)arrayWithJson
{
    return [self jsonValue];
}


- (NSDictionary *)dictionaryWithJson
{
    return [self jsonValue];
}

- (id)jsonValue
{
    NSError *__autoreleasing error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:self options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

@end
