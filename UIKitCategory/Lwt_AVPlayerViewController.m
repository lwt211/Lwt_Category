//
//  Lwt_AVPlayerViewController.m
//  shuangtu
//
//  Created by 李文韬 on 16/9/23.
//  Copyright © 2016年 TD_. All rights reserved.
//

#import "Lwt_AVPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface Lwt_AVPlayerViewController ()

@end

@implementation Lwt_AVPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UISwipeGestureRecognizer * rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] init];
    [rightSwipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [rightSwipeGestureRecognizer addTarget:self action:@selector(swipe:)];
    
    [self.view addGestureRecognizer:rightSwipeGestureRecognizer];
    
    UISwipeGestureRecognizer * leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] init];
    [leftSwipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    [leftSwipeGestureRecognizer addTarget:self action:@selector(swipe:)];
    
    
    [self.view addGestureRecognizer:leftSwipeGestureRecognizer];
   

}
    
    
- (void)swipe:(UISwipeGestureRecognizer *)swipe
    {
        
        AVPlayerItem *item = self.player.currentItem;
        
        NSInteger totalTime = CMTimeGetSeconds(item.duration);
        NSInteger currentTime = CMTimeGetSeconds(item.currentTime);
        
        if (swipe.direction == UISwipeGestureRecognizerDirectionLeft)
        {
            if (currentTime <= _seekTime)
            {
                [self.player seekToTime:CMTimeMake(0, 1)];
                
            }else
            {
                [self.player seekToTime:CMTimeMake(currentTime-_seekTime, 1)];
            }
            
        }else if (swipe.direction == UISwipeGestureRecognizerDirectionRight)
        {
            
            if (currentTime+_seekTime >= totalTime)
            {
                [self.player seekToTime:CMTimeMake(totalTime, 1)];
            }else
            {
                [self.player seekToTime:CMTimeMake(currentTime+_seekTime, 1)];
            }
        }
    }
    

    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
