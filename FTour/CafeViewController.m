//
//  CafeViewController.m
//  FTour
//
//  Created by Khanhhoa Mai on 7/8/14.
//  Copyright (c) 2014 FSoft. All rights reserved.
//

#import "CafeViewController.h"

@interface CafeViewController ()
@property (strong, nonatomic) IBOutlet UITableView *orderTbl;

@end

@implementation CafeViewController

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
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.title = @"Cafe Terrace";
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(toMenuView)];
    self.navigationItem.rightBarButtonItem = barBtn;
}

-(void)toMenuView
{
    [[[UIAlertView alloc]initWithTitle:@"OK" message:@"Ok buddy move on" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil]show];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
