//
//  Lwt_TextView.h
//  App
//
//  Created by 李文韬 on 16/1/14.
//  Copyright © 2016年 com.wentao. All rights reserved.
//


#import <UIKit/UIKit.h>



@protocol Lwt_TextViewDelegate;





@interface Lwt_TextView : UITextView



@property(copy,nonatomic) NSString *placeholder;

@property(strong,nonatomic) UIColor *placeholderColor;

@property(strong,nonatomic) UIFont * placeholderFont;


@property (nonatomic,weak) id <Lwt_TextViewDelegate> myDelegate;


@end



@protocol Lwt_TextViewDelegate <NSObject>


@optional

- (void)TextViewTextDidBeginEditing:(Lwt_TextView *)textView;

- (void)TextViewTextDidEndEditing:(Lwt_TextView *)textView;

- (void)TextViewTextDidChangeEditing:(Lwt_TextView *)textView;

- (void)TextViewTextShouldReturn:(Lwt_TextView *)textView;

@end




