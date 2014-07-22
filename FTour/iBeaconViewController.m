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
//    self.navigationItem.title = @"iBeacon";
//    self.navigationItem.hidesBackButton = NO;
    [[self navigationController]setNavigationBarHidden:NO];
    _uuid = [[NSUUID alloc]initWithUUIDString:kFSoftUUID];
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
    
    _beaconPeripheralData = [_beaconRegion peripheralDataWithMeasuredPower:[NSNumber numberWithInteger:-59]];
    _peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];

    [_uuidLbl setText:_beaconRegion.proximityUUID.UUIDString];
    [_uuidTitle setHidden:NO];
    [_majorTxt setText:[NSString stringWithFormat:@"%@",_beaconRegion.major]];
    [_majorTitle setHidden:NO];
    [_minorTxt setText:[NSString stringWithFormat:@"%@",_beaconRegion.minor]];
    [_minorTitle setHidden:NO];
    [_idTitle setHidden:NO];
    [_idtXT setText:_beaconRegion.identifier];
    
}

#pragma mark - CBPeripheraManager Delegate

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    if(peripheral.state == CBPeripheralManagerStatePoweredOn)
    {
        NSLog(@"On");
        [_status setText:@"Broadcasting..."];
        [peripheral startAdvertising:_beaconPeripheralData];
        _btnStatus.titleLabel.text = @"Off";
    }
//    if(peripheral.state == CBPeripheralManagerStatePoweredOff)
//    {
//        NSLog(@"Off");
//        [_status setText:@"Stopped"];
//        [peripheral stopAdvertising];
//    }
    
}
- (IBAction)btnOff:(id)sender {
    //_peripheralManager stopAdvertising: _beaconRegion];
    [_peripheralManager removeAllServices];
    [_peripheralManager stopAdvertising];
    NSLog(@"Stop");
    [_status setText:@"Stopped"];
    _btnStatus.titleLabel.text = @"";
    [_segment setSelectedSegmentIndex:-1];
}
@end
