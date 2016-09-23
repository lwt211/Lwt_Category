//
//  UIImage+Lwt.m
//  App
//
//  Created by 李文韬 on 16/1/14.
//  Copyright © 2016年 com.wentao. All rights reserved.
//

#import "UIImage+Lwt.h"




@implementation UIImage (Lwt)


// 裁剪图片
- (UIImage *)croppedImage:(CGRect)rect
{
    CGImageRef imageRef   = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return croppedImage;
}


// 缩放图片 不剪切
- (UIImage *)resizeImageWithNewSize:(CGSize)newSize {
    CGFloat newWidth  = newSize.width;
    CGFloat newHeight = newSize.height;
    float width       = self.size.width;
    float height      = self.size.height;
    
    if (width == 0 || height == 0){
        return self;
    }
    
    if (width != newWidth || height != newHeight) {
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
        [self drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
        UIImage *resized = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        //NSData *jpeg = UIImageJPEGRepresentation(image, 0.8);
        return resized;
    }
    return self;
}

//等比，居中剪切
- (UIImage *)croppedCenterImage:(CGSize)size{
    CGFloat scaleW = self.size.width/size.width;
    CGFloat scaleH = self.size.height/size.height;
    if(self.size.width > 1 || self.size.height > 1){
        if(scaleH < scaleW){
            
            //得到要剪切的大小
            CGSize scaleSize = CGSizeMake(size.width*scaleH, size.height*scaleH);
            //剪切
            CGRect rect      = CGRectMake((self.size.width-scaleSize.width)/2, 0, scaleSize.width, scaleSize.height);
            UIImage *img     = [self croppedImage:rect];
            return img;
        }else{
            
            //得到要剪切的大小
            CGSize scaleSize = CGSizeMake(size.width*scaleW, size.height*scaleW);
            //剪切
            CGRect rect      = CGRectMake(0, (self.size.height-scaleSize.width)/2, scaleSize.width, scaleSize.height);
            UIImage *img     = [self croppedImage:rect];
            return img;
        }
    }
    return self;
}
- (UIImage *)imageRotatedByRadians:(CGFloat)radians
{
    return [self imageRotatedByDegrees:radians * 180/M_PI];
}

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees
{
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox   = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t      = CGAffineTransformMakeRotation(degrees * M_PI / 180);
    rotatedViewBox.transform = t;
    CGSize rotatedSize       = rotatedViewBox.frame.size;
    
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap,degrees * M_PI / 180);
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}

-(UIColor*)mostColor{
    
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    CGSize thumbSize=CGSizeMake(50, 50);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width*4,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, self.CGImage);
    CGColorSpaceRelease(colorSpace);
    
    
    CGBitmapContextGetData (context);
    
    //第二步 取每个点的像素值
    unsigned char * data = CGBitmapContextGetData (context);
    
    
    if (data == NULL) return nil;
    
    NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    
    for (int x=0; x<thumbSize.width; x++) {
        for (int y=0; y<thumbSize.height; y++) {
            
            int offset = 4*(x*y);
            
            int red    = data[offset];
            int green  = data[offset+1];
            int blue   = data[offset+2];
            int alpha  = data[offset+3];
            
            NSArray *clr=@[@(red),@(green),@(blue),@(alpha)];
            [cls addObject:clr];
            
        }
    }
    CGContextRelease(context);
    
    
    //第三步 找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor        = nil;
    
    NSArray *MaxColor        = nil;
    NSUInteger MaxCount      = 0;
    
    while ( (curColor = [enumerator nextObject]) != nil )
    {
        NSUInteger tmpCount = [cls countForObject:curColor];
        
        if ( tmpCount < MaxCount ) continue;
        
        MaxCount=tmpCount;
        MaxColor=curColor;
    }
    
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}

- (UIImage *)imageWithTintColor:(UIColor *)tintColor
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

- (UIImage *)resizedImageWithBounds:(CGSize)bounds
{
    CGFloat horizontalRatio = bounds.width / self.size.width;
    CGFloat verticalRatio = bounds.height / self.size.height;
    CGFloat ratio = MAX(horizontalRatio, verticalRatio);
    
    CGSize newSize = CGSizeMake(self.size.width * ratio,self.size.height * ratio);
    NSLog(@"%f", self.size.width);
    NSLog(@"%f", self.size.height);
    NSLog(@"%f", horizontalRatio);
    NSLog(@"%f", verticalRatio);
    NSLog(@"%f", newSize.width);
    NSLog(@"%f", newSize.height);
    
    //  NSLog(@"%f", newSize.height);
    UIGraphicsBeginImageContextWithOptions(newSize, YES, 0);
    [self drawInRect:CGRectMake(0, 0, newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


+(UIImage *)imageWithUIView:(UIView*) view{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    //[view.layer drawInContext:currnetContext];
    [view.layer renderInContext:currnetContext];
    // 从当前context中创建一个改变大小后的图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return image;
}

+(UIImage *)imageWithColor:(UIColor*)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context,
                                   
                                   color.CGColor);
    
    CGContextFillRect(context, rect);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}


@end
