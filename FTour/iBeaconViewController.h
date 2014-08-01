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
@property (strong, nonatomic) IBOutlet UILabel *uuidLbl;
@property (nonatomic, strong) CLBeaconRegion *beaconRegion;
@property (nonatomic, strong) NSDictionary *beaconPeripheralData;
@property (nonatomic, strong) CBPeripheralManager *peripheralManager;
@property (nonatomic,strong) NSUUID *uuid;
@property (strong, nonatomic) IBOutlet UILabel *uuidTitle;
@property (strong, nonatomic) IBOutlet UILabel *majorTitle;
@property (strong, nonatomic) IBOutlet UILabel *minorTitle;
@property (strong, nonatomic) IBOutlet UILabel *idTitle;
@property (strong, nonatomic) IBOutlet UILabel *majorTxt;
@property (strong, nonatomic) IBOutlet UILabel *minorTxt;
@property (strong, nonatomic) IBOutlet UILabel *idTxt;
- (IBAction)btnOff:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnStatus;
@property (weak, nonatomic) IBOutlet UIImageView *imgBroadcast;

@end
