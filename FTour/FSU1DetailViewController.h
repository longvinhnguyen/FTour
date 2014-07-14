//
//  FSU1DetailViewController.h
//  FTour
//
//  Created by Tuan An on 14/07/2014.
//  Copyright (c) Năm 2014 FSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSU1DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbEmail;
@property (weak, nonatomic) IBOutlet UILabel *lbTel;

- (IBAction)btnCall:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSendEmail;
@property (strong, nonatomic) NSDictionary * detailDict;
@end
