//
//  iBeaconViewController.h
//  FTour
//
//  Created by Khanhhoa Mai on 7/8/14.
//  Copyright (c) 2014 FSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iBeaconViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISegmentedControl *segment;

@property (nonatomic, strong) CLBeaconRegion *beaconRegion;
@property (nonatomic, strong) NSDictionary *beaconPeripheralData;
@property (nonatomic, strong) CBPeripheralManager *peripheralManager;
@property (nonatomic,strong) NSUUID *uuid;
@property (weak, nonatomic) IBOutlet UIButton *btnStatus;
@property (weak, nonatomic) IBOutlet UIImageView *imgBroadcast;
@property (strong, nonatomic) IBOutlet UILabel *uuidLabel;
@property (strong, nonatomic) IBOutlet UILabel *uuidValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *majorLabel;
@property (strong, nonatomic) IBOutlet UILabel *majorValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *minorLabel;
@property (strong, nonatomic) IBOutlet UILabel *minorValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *idLabel;
@property (strong, nonatomic) IBOutlet UILabel *idValueLabel;

@end
