//
//  WelcomeViewController.h
//  FTour
//
//  Created by Khanhhoa Mai on 7/8/14.
//  Copyright (c) 2014 FSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface WelcomeViewController : UIViewController <CLLocationManagerDelegate,CBPeripheralManagerDelegate>

@property (nonatomic, strong) CLBeaconRegion *beaconRegion;
@property (nonatomic, strong) CLBeaconRegion *beaconRegionFSoft;
@property (nonatomic, strong) CLBeaconRegion *beaconRegionFSu1;
@property (nonatomic, strong) CLBeaconRegion *beaconRegionCafe;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UILabel *statusLable;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end
