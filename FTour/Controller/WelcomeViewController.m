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
{
    UIDynamicAnimator * _animator;
    UIGravityBehavior * _gravity;
    UICollisionBehavior * _collision;
    CBCentralManager *cbCentralManager;
    UIAlertView *ua;

}
@end
@implementation WelcomeViewController
- (IBAction)btnClicked:(id)sender {
    [self loadFSu1];
}

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
    [self initAnimation];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAlertBluetoothOff) name:@"reLaunchApp" object:nil];
    ua = [[UIAlertView alloc]initWithTitle:@"Bluetooth are unavailable" message:@"Please turn on your bluetooth" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Setting", nil];
}

-(void)viewDidAppear:(BOOL)animated{
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    
    NSUUID *uuid = [[NSUUID alloc]initWithUUIDString:kFSoftUUID];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:@"FSoft"];
    [self.locationManager startMonitoringForRegion:self.beaconRegion];
    [self initAnimation];
    UISwipeGestureRecognizer *swipeBackGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(didSwipeBack)];
    [swipeBackGesture setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeBackGesture];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{
    
}


#pragma mark - Animation

-(void)initAnimation{
    NSArray *imageNames=[NSArray arrayWithObjects:@"circle copy3.png",@"circle copy4.png",nil];
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageNames.count; i++)
    {
        [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    }
    _imgFtour.animationImages = images;
    _imgFtour.animationDuration = 1.4;
    [_imgFtour startAnimating];
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _gravity = [[UIGravityBehavior alloc] initWithItems:@[_imgFtour]];
    [_animator addBehavior:_gravity];
    _collision = [[UICollisionBehavior alloc]
                  initWithItems:@[_imgFtour]];
    _collision.translatesReferenceBoundsIntoBoundary = YES;
    [_animator addBehavior:_collision];
}
- (void)showAlertBluetoothOff
{
    [ua show];
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

#pragma mark - Navigation

-(void) didSwipeBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadFsoft
{
    FSoftViewController *fsoftView = [[FSoftViewController alloc]initWithNibName:@"FSoftViewController" bundle:nil];
    [[self navigationController]pushViewController:fsoftView animated:YES];
}
-(void)loadFSu1
{
     FSU1ViewController *fsu1View = [[FSU1ViewController alloc]initWithNibName:@"FSU1ViewController" bundle:nil];
    [[self navigationController]pushViewController:fsu1View animated:YES];
}
-(void)loadCafe
{
    CafeViewController *cafeView = [[CafeViewController alloc]initWithNibName:@"CafeViewController" bundle:nil];
    [[self navigationController]pushViewController:cafeView animated:YES];
}
-(void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    NSLog(@"%@", [region class].description);
    [_locationManager startRangingBeaconsInRegion:_beaconRegion];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
     if (buttonIndex == 1)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=General&path=Bluetooth"]];
            NSLog(@"Showed");
        }
}

@end
