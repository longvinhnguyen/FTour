//
//  FSoftViewController.m
//  FTour
//
//  Created by Khanhhoa Mai on 7/8/14.
//  Copyright (c) 2014 FSoft. All rights reserved.
//

#import "FSoftViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface FSoftViewController ()

@end

@implementation FSoftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

   NSURL *url =    [NSURL fileURLWithPath:[[NSBundle mainBundle]
                            pathForResource:@"Video_2014_08_03_223123" ofType:@"mp4"]];
    self.videoController = [[MPMoviePlayerController alloc] init];
    self.videoController.controlStyle = MPMovieControlStyleFullscreen;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doneButtonClicked:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [self.videoController setContentURL:url];
    [self.videoController.view setFrame:self.viewFull.bounds];
    [self.view addSubview:self.videoController.view];
    self.videoController.controlStyle = MPMovieControlStyleNone;

    [self.videoController prepareToPlay];
    [self.videoController play];
    [self.videoController setFullscreen:YES animated:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopCurrentView) name:@"kNotificationDidLostBeacon" object:nil];
}
- (void)stopCurrentView
{
    // Exit current view
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)videoPlayBackDidFinish:(NSNotification *)notification {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    // Stop the video player and remove it from view
    [self.videoController stop];
    [self.videoController.view removeFromSuperview];
    self.videoController = nil;
    
}
-(void)doneButtonClicked:(NSNotification*)aNotification
{
        [self.videoController stop];
        [self.videoController.view removeFromSuperview];
        [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
