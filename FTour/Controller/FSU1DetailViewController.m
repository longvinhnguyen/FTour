//
//  FSU1DetailViewController.m
//  FTour
//
//  Created by Tuan An on 14/07/2014.
//  Copyright (c) Năm 2014 FSoft. All rights reserved.
//

#import "FSU1DetailViewController.h"
#import "Contact.h"


@interface FSU1DetailViewController ()
{
}
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
        [self.lbEmail setText:[NSString stringWithFormat:@"%@",self.detailContact.email]];
        [self.lbName setText:[NSString stringWithFormat:@"%@",self.detailContact.name]];
    if (![self.detailContact.phoneNumber isEqualToString:@""]) {
            [self.lbTel setText:[NSString stringWithFormat:@"%@",self.detailContact.phoneNumber]];
    }
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)stopCurrentView
{
    NSLog(@"Stop broadcast");
    if ([self.navigationController.viewControllers count] >= 2)
    {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCall:(id)sender {
    NSString *str = [NSString stringWithFormat:@"tel:%@",self.detailContact.phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (IBAction)btnSendEmail:(id)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
                MFMailComposeViewController *mc = [[MFMailComposeViewController alloc]init];
                mc.mailComposeDelegate = self;
                [mc setSubject:@"FTour guess"];
                NSString *a =  self.lbEmail.text;
                [mc setToRecipients:[NSArray arrayWithObject:a]];
                [self presentViewController:mc animated:YES completion:NULL];
    }
            else
            {
                UIAlertView *aView = [[UIAlertView alloc]initWithTitle:@"Email Setup" message:@"Please set-up your email account before using this function" delegate:nil cancelButtonTitle:@"Got it" otherButtonTitles:nil, nil];
                [aView show];
            }
}
- (void) mailComposeController: (MFMailComposeViewController *) controller
           didFinishWithResult: (MFMailComposeResult) result
                         error: (NSError *) error {
    
    if(result == MFMailComposeResultSent){
        [self dismissViewControllerAnimated:YES completion:NULL];
    } else if (result == MFMailComposeResultCancelled) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}
@end
