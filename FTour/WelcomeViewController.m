//
//  WelcomeViewController.m
//  FTour
//
//  Created by Khanhhoa Mai on 7/8/14.
//  Copyright (c) 2014 FSoft. All rights reserved.
//

#import "WelcomeViewController.h"


@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

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
//
//    NSUUID *uuid = [[NSUUID alloc]initWithUUIDString:KFSoftUUID];
//    self.beaconRegion = [[CLBeaconRegion alloc]initWithProximityUUID:uuid major:1 identifier:@"FSoft"];
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    
    NSUUID *uuid = [[NSUUID alloc]initWithUUIDString:kFSoftUUID];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:@"Fsoft"];
    [self.locationManager startMonitoringForRegion:self.beaconRegion];
    
    
}
-(void) peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    
}
-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"Founded");
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
//    CLBeacon *foundBeacon = [beacons firstObject];
    s
    if(foundBeacon.major.intValue ==1)
       [self loadFsoft];
    if (foundBeacon.major.intValue == 2) {
        [self loadFSu1];
    }
}
-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    [self
     .locationManager stopRangingBeaconsInRegion:self.beaconRegion];
    self.statusLable.text = @"Out of Range";
    NSLog(@"lost");
}
-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    CLBeacon *foundBeacon = [beacons firstObject];
    switch (foundBeacon.major.intValue) {
        case 1:
            [self loadFsoft];
            NSLog(@"FSoft");
            //self.barProgress.progress =
            //[self loadFsoft];
            break;
        case 2:
            [self loadFSu1];
            break;
        case 3:
            [self loadCafe];
            break;
        default:
            break;
    }
}

-(void)loadFsoft
{
    
    UIAlertView *msg = [[UIAlertView alloc]initWithTitle:@"Welcome to FSoft" message:@"You are at Reception" delegate:nil cancelButtonTitle:@"Got it" otherButtonTitles:nil, nil];
    [msg show];
}
-(void)loadFSu1
{
    
    UIAlertView *msg = [[UIAlertView alloc]initWithTitle:@"Welcome to FSu1" message:@"You are at FSu1" delegate:nil cancelButtonTitle:@"Got it" otherButtonTitles:nil, nil];
    [msg show];
}
-(void)loadCafe
{
    
    UIAlertView *msg = [[UIAlertView alloc]initWithTitle:@"Welcome to Cafe" message:@"You are at Cafe" delegate:nil cancelButtonTitle:@"Got it" otherButtonTitles:nil, nil];
    [msg show];
}
-(void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    NSLog(@"%@", [region class].description);
    [_locationManager startRangingBeaconsInRegion:_beaconRegion];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
