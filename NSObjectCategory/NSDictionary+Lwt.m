//
//  NSDictionary+Lwt.m
//  App
//
//  Created by 李文韬 on 16/1/14.
//  Copyright © 2016年 com.wentao. All rights reserved.
//

#import "NSDictionary+Lwt.h"

@implementation NSDictionary (Lwt)

- (NSDictionary *)CheckNullInDic {
    
    
    NSMutableDictionary *mutDic = [[NSMutableDictionary alloc] init];
    for (NSString *key in self)
    {
        //        NSLog(@"%@",key);
        
        id object = self[key];
        if (![object isEqual:[NSNull null]])
        {
            id value;
            if ([object isKindOfClass:[NSNumber class]])
            {
                value = [NSString stringWithFormat:@"%@",object];
            }
            else if([object isKindOfClass:[NSString class]])
            {
                if ([object isEqualToString:@"<null>"]||[object isEqualToString:@"(null)"])
                {
                    
                    value = @"";
                }
                
                value = object;
            }else if([object isKindOfClass:[NSDictionary class]])
            {
                value = [object CheckNullInDic];
            }else if ([object isKindOfClass:[NSArray class]])
            {
                value = [self checkArrInDictionary:object];
            }else
            {
                value = object;
            }
            
            [mutDic setObject:value forKey:key];
            
        }else
        {
            [mutDic setObject:@"" forKey:key];
        }
    }
    

    return mutDic;
}

- (NSArray *)checkArrInDictionary:(NSArray *)arr
{
    NSMutableArray * value = [[NSMutableArray alloc] init];
    
    for (id results in arr)
    {
        if ([results isKindOfClass:[NSDictionary class]])
        {
            [value addObject:[results CheckNullInDic]];
            
        }else if ([results isKindOfClass:[NSArray class]])
        {
            
            [value addObject:[self checkArrInDictionary:results]];
        }else
        {
            if (![results isEqual:[NSNull null]])
            {
                if ([results isKindOfClass:[NSNumber class]])
                {
                    [value addObject:[NSString stringWithFormat:@"%@",results]];
                }
                else if([results isKindOfClass:[NSString class]])
                {
                    if ([results isEqualToString:@"<null>"]||[results isEqualToString:@"(null)"])
                    {
                        [value addObject:@""];
                    }
                    
                    [value addObject:results];
                }
                
            }else
                
            {
                [value addObject:@""];
            }
        }
        
    }
    return value;
}



- (BOOL)getBoolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue {
    return [self objectForKey:key] == [NSNull null] ? defaultValue
    : [[self objectForKey:key] boolValue];
}

- (int)getIntValueForKey:(NSString *)key defaultValue:(int)defaultValue {
    return [self objectForKey:key] == [NSNull null]
				? defaultValue : [[self objectForKey:key] intValue];
}

- (long long)getLongLongValueValueForKey:(NSString *)key defaultValue:(long long)defaultValue {
    return [self objectForKey:key] == [NSNull null]
    ? defaultValue : [[self objectForKey:key] longLongValue];
}

- (NSString *)getStringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue {
    return [self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null]
				? defaultValue : [self objectForKey:key];
}
- (NSNumber *)getNumberValueForKey:(NSString *)key defaultValue:(NSNumber *)defaultValue
{
    return [self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null]
				? defaultValue : [self objectForKey:key];
}

@end
