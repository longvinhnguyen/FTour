//
//  FSU1DetailViewController.h
//  FTour
//
//  Created by Tuan An on 14/07/2014.
//  Copyright (c) Năm 2014 FSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "Contact.h"

@interface FSU1DetailViewController : UIViewController <MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbEmail;
@property (weak, nonatomic) IBOutlet UILabel *lbTel;

- (IBAction)btnCall:(id)sender;
- (IBAction)btnSendEmail:(id)sender;

@property (strong, nonatomic) Contact * detailContact;
@end
