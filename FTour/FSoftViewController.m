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
                            pathForResource:@"FSoftIntro" ofType:@"mov"]];
    self.videoController = [[MPMoviePlayerController alloc] init];
    self.videoController.controlStyle = MPMovieControlStyleFullscreen;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doneButtonClicked:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [self.videoController setContentURL:url];
    [self.videoController.view setFrame:self.viewFull.bounds];
    [self.view addSubview:self.videoController.view];
    [self.videoController prepareToPlay];
    [self.videoController play];
    [self.videoController setFullscreen:YES animated:YES];
}

- (void)videoPlayBackDidFinish:(NSNotification *)notification {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    // Stop the video player and remove it from view
    [self.videoController stop];
    [self.videoController.view removeFromSuperview];
    self.videoController = nil;
    //[self.videoController : UIInterfaceOrientationLandscapeRight];

    
    // Display a message
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Video Playback" message:@"Just finished the video playback. The video is now removed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
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

@end
