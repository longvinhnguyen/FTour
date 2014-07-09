//
//  WelcomeViewController.m
//  FTour
//
//  Created by Khanhhoa Mai on 7/8/14.
//  Copyright (c) 2014 FSoft. All rights reserved.
//

#import "WelcomeViewController.h"
#import "FSoftViewController.h"

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
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:@"FSoft"];
    self.beaconRegionFSoft = [[CLBeaconRegion alloc] initWithProximityUUID:uuid major:1 identifier:@"FSoft"];
    self.beaconRegionFSu1 = [[CLBeaconRegion alloc]initWithProximityUUID:uuid major:2 identifier:@"FSu1"];
    self.beaconRegionCafe = [[CLBeaconRegion alloc]initWithProximityUUID:uuid major:3 identifier:@"Cafe"];
    
    [self.locationManager startMonitoringForRegion:self.beaconRegion];
}
-(void) peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    
}
-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"Founded");
    
    if([region.identifier isEqualToString:@"FSoft"])
        self.statusLable.text = @"FSoft";
    if ([region.identifier isEqualToString:@"FSu1"])
        self.statusLable.text = @"FSu1";
    if ([region.identifier isEqualToString:@"Cafe"])
        self.statusLable.text = @"Cafe";
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
            [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
            break;
        case 2:
            [self loadFSu1];
            [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
            break;
        case 3:
            [self loadCafe];
             [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
            break;
        default:
            break;
    }
}

-(void)loadFsoft
{
    FSoftViewController *vc = [[FSoftViewController alloc] initWithNibName:@"FSoftViewController" bundle:nil];
//    [[[[[UIApplication sharedApplication] delegate]window] rootViewController]presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
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
