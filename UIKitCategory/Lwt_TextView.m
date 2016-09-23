//

//  Lwt_TextView.m
//  App
//
//  Created by 李文韬 on 16/1/14.
//  Copyright © 2016年 com.wentao. All rights reserved.
//

#import "Lwt_TextView.h"

@interface Lwt_TextView ()<UITextViewDelegate>
{
    UILabel *_placeholderLabel;
}



@end


@implementation Lwt_TextView


- (void)dealloc
{
    NSLog(@"Lwt_TextView release");
    [_placeholderLabel removeFromSuperview];
    _placeholder = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame])
    {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textEndEditing:) name:UITextViewTextDidEndEditingNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextViewTextDidChangeNotification object:nil];
        
        float left=5,top=2,hegiht=30;
        
        self.placeholderColor = [UIColor lightGrayColor];
        _placeholderLabel=[[UILabel alloc] initWithFrame:CGRectMake(left, top
                                                                    , CGRectGetWidth(self.frame)-2*left, hegiht)];
        _placeholderLabel.font=self.placeholderFont?self.placeholderFont:self.font;
        _placeholderLabel.textColor=self.placeholderColor;
        [self addSubview:_placeholderLabel];
        _placeholderLabel.text=self.placeholder;
        
        self.delegate = self;
        
        
    }
    return self;
}


-(void)setPlaceholder:(NSString *)placeholder{
    if (placeholder.length == 0 ||[placeholder isEqualToString:@""])
    {
        _placeholderLabel.hidden=YES;
    }
    else
    {
        _placeholderLabel.text=placeholder; 
    }
    _placeholder= placeholder;
    
}

- (void)textBeginEditing:(NSNotification*)notification
{
   
    if ([self.myDelegate respondsToSelector:@selector(TextViewTextDidBeginEditing:)])
    {
         __weak typeof(self) weakSelf = self;
        [self.myDelegate TextViewTextDidBeginEditing:weakSelf];
    }
}

- (void)textEndEditing:(NSNotification*)notification
{
    
    if ([self.myDelegate respondsToSelector:@selector(TextViewTextDidEndEditing:)])
    {
        __weak typeof(self) weakSelf = self;
        [self.myDelegate TextViewTextDidEndEditing:weakSelf];
    }
    
}

- (void)textChange:(NSNotification*)notification
{
    if (self.placeholder.length == 0 || [self.placeholder isEqualToString:@""]) {
        _placeholderLabel.hidden=YES;
    }
    
    if (self.text.length > 0) {
        _placeholderLabel.hidden=YES;
    }
    else{
        _placeholderLabel.hidden=NO;
    }

    if ([self.myDelegate respondsToSelector:@selector(TextViewTextDidChangeEditing:)])
    {
        __weak typeof(self) weakSelf = self;
        [self.myDelegate TextViewTextDidChangeEditing:weakSelf];
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"])
    {
        if ([self.myDelegate respondsToSelector:@selector(TextViewTextShouldReturn:)])
        {
            __weak typeof(self) weakSelf = self;
          [self.myDelegate TextViewTextShouldReturn:weakSelf];
        }
        return NO;

    }
    
    return YES;
}



@end
