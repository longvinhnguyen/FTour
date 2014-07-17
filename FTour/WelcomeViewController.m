//
//  WelcomeViewController.m
//  FTour
//
//  Created by Khanhhoa Mai on 7/8/14.
//  Copyright (c) 2014 FSoft. All rights reserved.
//

#import "WelcomeViewController.h"
#import "FSoftViewController.h"
#import "FSU1ViewController.h"
#import "CafeViewController.h"

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
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    
    NSUUID *uuid = [[NSUUID alloc]initWithUUIDString:kFSoftUUID];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:@"FSoft"];
    [self.locationManager startMonitoringForRegion:self.beaconRegion];
    NSArray *imageNames=[NSArray arrayWithObjects:@"FTourlogoV2.png.png",@"FTourlogoV22.png",nil];
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageNames.count; i++) {
        [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    }
    _imgFtour.animationImages = images;
    _imgFtour.animationDuration = 1.4;
    [_imgFtour startAnimating];
}
-(void)viewDidAppear:(BOOL)animated{
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    
    NSUUID *uuid = [[NSUUID alloc]initWithUUIDString:kFSoftUUID];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:@"FSoft"];
    [self.locationManager startMonitoringForRegion:self.beaconRegion];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}
-(void) peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    
}
- (void)locationManager:(CLLocationManager*)manager didEnterRegion:(CLRegion*)region
{
    NSLog(@"didEnter");
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

-(void)locationManager:(CLLocationManager*)manager didExitRegion:(CLRegion*)region
{
    [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
    NSLog(@"Lost");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"kNotificationDidLostBeacon" object:nil];
}
-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    CLBeacon *foundBeacon = [beacons firstObject];
    switch (foundBeacon.major.intValue) {
        case 1:
            [self loadFsoft];
            [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
            NSLog(@"Load FSoft View");
            break;
        case 2:
            [self loadFSu1];
            [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
            NSLog(@"Load FSu1 view");
            break;
        case 3:
            [self loadCafe];
            [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
            NSLog(@"LoadCafe view");
            break;
        default:
            break;
    }
}


-(void)loadFsoft
{
    FSoftViewController *vc = [[FSoftViewController alloc]initWithNibName:@"FSoftViewController" bundle:nil];
    [[self navigationController]pushViewController:vc animated:YES];
   // [[[[[UIApplication sharedApplication]delegate]window]rootViewController]presentViewController:vc animated:YES completion:nil];
}
-(void)loadFSu1
{
     FSU1ViewController *vc = [[FSU1ViewController alloc]initWithNibName:@"FSU1ViewController" bundle:nil];
    [[self navigationController]pushViewController:vc animated:YES];
}
-(void)loadCafe
{
    CafeViewController *vc = [[CafeViewController alloc]initWithNibName:@"CafeViewController" bundle:nil];
    [[self navigationController]pushViewController:vc animated:YES];
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
