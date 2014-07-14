//
//  FSU1DetailViewController.m
//  FTour
//
//  Created by Tuan An on 14/07/2014.
//  Copyright (c) Năm 2014 FSoft. All rights reserved.
//

#import "FSU1DetailViewController.h"

@interface FSU1DetailViewController ()

@end

@implementation FSU1DetailViewController

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
        [self.lbEmail setText:[NSString stringWithFormat:@"%@",[self.detailDict objectForKey:@"email"]]];
        [self.lbName setText:[NSString stringWithFormat:@"%@",[self.detailDict objectForKey:@"name"]]];
        [self.lbTel setText:[NSString stringWithFormat:@"%@",[self.detailDict objectForKey:@"tel"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCall:(id)sender {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[self.detailDict objectForKey:@"tel"]]]];
}
@end
