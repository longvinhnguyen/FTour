//
//  FSU1ViewController.h
//  FTour
//
//
//  Created by Khanhhoa Mai on 7/8/14.
//  Copyright (c) 2014 FSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface FSU1ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>
{
    IBOutlet UITableView *mainTable;
    NSMutableArray *dataArray;
}
@end
