//
//  ViewController.m
//  FTour
//
//  Created by LongNV on 7/7/14.
//  Copyright (c) 2014 FSoft. All rights reserved.
//

#import "BaseViewController.h"
#import "iBeaconViewController.h"
#import "WelcomeViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

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

    iBeaconViewController *viewController = [[iBeaconViewController alloc] initWithNibName:@"iBeaconViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(IBAction)proximityMe:(id)sender
{
    WelcomeViewController *viewController = [[WelcomeViewController alloc]initWithNibName:@"WelcomeViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}
@end
