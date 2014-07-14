//
//  FSoftViewController.h
//  FTour
//
//  Created by Khanhhoa Mai on 7/8/14.
//  Copyright (c) 2014 FSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface FSoftViewController : UIViewController
@property (strong, nonatomic) NSURL *videoURL;
@property (strong, nonatomic) MPMoviePlayerController *videoController;
@property (weak, nonatomic) IBOutlet UIView *viewFull;
@property (nonatomic, strong) CLBeaconRegion *beaconRegion;
@property (nonatomic, strong) CLLocationManager *locationManager;
- (void)postNotificationWithString:(NSString *)orientation;
- (void)useNotificationWithString:(NSNotification*)notification;

@end
