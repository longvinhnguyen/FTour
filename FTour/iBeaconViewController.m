//
//  iBeaconViewController.m
//  FTour
//
//  Created by Khanhhoa Mai on 7/8/14.
//  Copyright (c) 2014 FSoft. All rights reserved.
//

#import "iBeaconViewController.h"

@interface iBeaconViewController ()<CBPeripheralManagerDelegate>

@end

@implementation iBeaconViewController

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
    _uuid = [[NSUUID alloc]initWithUUIDString:@"77F353D0-285C-4606-B012-8A078FB96622"];
//    _beaconRegion = [[CLBeaconRegion alloc]initWithProximityUUID:_uuid major:1 minor:1 identifier:@"FSoft Entrance"];
//    _beaconPeripheralData = [_beaconRegion peripheralDataWithMeasuredPower:nil];
//    _peripheralManager = [[CBPeripheralManager alloc]initWithDelegate:self queue:nil options:nil];
//    [_uuidLbl setText:_beaconRegion.proximityUUID.UUIDString];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)segChanged:(id)sender
{
    if(_segment.selectedSegmentIndex == 0)
    {
        _beaconRegion = [[CLBeaconRegion alloc]initWithProximityUUID:_uuid major:1 minor:1 identifier:@"FSoft Entrance"];
    }
    else if (_segment.selectedSegmentIndex == 1) {
        _beaconRegion = [[CLBeaconRegion alloc]initWithProximityUUID:_uuid major:2 minor:1 identifier:@"FSU1"];
    }
    else
    {
        _beaconRegion = [[CLBeaconRegion alloc]initWithProximityUUID:_uuid major:3 minor:1 identifier:@"Cafe Terrace"];
    }
    
    _beaconPeripheralData = [_beaconRegion peripheralDataWithMeasuredPower:nil];
    _peripheralManager = [[CBPeripheralManager alloc]initWithDelegate:self queue:nil options:nil];
    [_uuidLbl setText:_beaconRegion.proximityUUID.UUIDString];
}

#pragma mark - CBPeripheraManager Delegate

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    if(peripheral.state == CBPeripheralManagerStatePoweredOn)
    {
        NSLog(@"On");
        [peripheral startAdvertising:_beaconPeripheralData];
    }
    if(peripheral.state == CBPeripheralManagerStatePoweredOff)
    {
        NSLog(@"Off");
        [peripheral stopAdvertising];
    }
    
}
@end
