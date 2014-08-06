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
    [[self navigationController]setNavigationBarHidden:NO];
    _uuid = [[NSUUID alloc]initWithUUIDString:kFSoftUUID];
    [_btnStatus setHidden:YES];
    [_peripheralManager addObserver:self forKeyPath:@"isAdvertising" options:0 context:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"isAdvertising"]) {
        {
            NSLog(@"Change");
        }
    }
    else
    {
        NSLog(@"Sure");
    }
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

    [_uuidLabel setHidden:NO];
    [_uuidValueLabel setText:_beaconRegion.proximityUUID.UUIDString];
    [_majorLabel setHidden:NO];
    [_majorValueLabel setText:[NSString stringWithFormat:@"%@",_beaconRegion.major]];
    [_minorLabel setHidden:NO];
    [_minorValueLabel setText:[NSString stringWithFormat:@"%@",_beaconRegion.minor]];
    [_idLabel setHidden:NO];
    [_idValueLabel setText:_beaconRegion.identifier];
    [self broadcastAnimation:YES];
}

#pragma mark - CBPeripheraManager Delegate

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    if(peripheral.state == CBPeripheralManagerStatePoweredOn)
    {
        NSLog(@"On");
        [peripheral startAdvertising:_beaconPeripheralData];
        _btnStatus.titleLabel.text = @"Off";
        [self broadcastAnimation:YES];
    }
}
- (IBAction)didPressStopButton:(id)sender {
    [_peripheralManager removeAllServices];
    [_peripheralManager stopAdvertising];
    NSLog(@"Stop");
    _btnStatus.titleLabel.text = @"";
    [_segment setSelectedSegmentIndex:-1];
    [self broadcastAnimation:NO];

}
#pragma mark - Animation

-(void)broadcastAnimation:(BOOL)status
{
    if (status) {
        NSArray *imageNames=[NSArray arrayWithObjects:@"broadcast1.png",@"broadcast2.png",nil];
        NSMutableArray *images = [[NSMutableArray alloc] init];
        for (int i = 0; i < imageNames.count; i++) {
            [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
        }
        _imgBroadcast.animationImages = images;
        _imgBroadcast.animationDuration = 0.75;
        [_imgBroadcast startAnimating];
        [_btnStatus setHidden:NO];
    }
    else
    {
        [_imgBroadcast stopAnimating];
        [_btnStatus setHidden:YES];
        
    }
}
@end
