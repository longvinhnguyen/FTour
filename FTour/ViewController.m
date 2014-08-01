//
//  ViewController.m
//  FTour
//
//  Created by LongNV on 7/7/14.
//  Copyright (c) 2014 FSoft. All rights reserved.
//

#import "ViewController.h"
#import "iBeaconViewController.h"
#import "WelcomeViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController]setNavigationBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)iBeaconMe:(id)sender
{
   // [[[UIAlertView alloc]initWithTitle:@"ok" message:@"now what" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil] show];
    iBeaconViewController *viewController = [[iBeaconViewController alloc] initWithNibName:@"iBeaconViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(IBAction)proximityMe:(id)sender
{
    WelcomeViewController *viewController = [[WelcomeViewController alloc]initWithNibName:@"WelcomeViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}
@end
