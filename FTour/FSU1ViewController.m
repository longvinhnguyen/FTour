//
//  FSU1ViewController.m
//  FTour
//
//  Created by Khanhhoa Mai on 7/8/14.
//  Copyright (c) 2014 FSoft. All rights reserved.
//
//

#import "FSU1ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AVFoundation/AVFoundation.h"


@interface FSU1ViewController ()
@end

@implementation FSU1ViewController
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
    NSLog(@"Loaded FSU1");
    
    dataArray = [[NSMutableArray alloc]init];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"FSU1_Data" ofType:@"json"];
    NSData *allFSU1Data = [[NSData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    NSDictionary *allFSU1 = [NSJSONSerialization JSONObjectWithData:allFSU1Data options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
//        NSArray *BuLead = allFSU1[@"BU Lead"];
        NSArray * buLead = [allFSU1 objectForKey:@"BU Lead"];
        NSArray *GeAs = allFSU1[@"General Assistant"];
        NSArray *iOS = allFSU1[@"Mobility iOS"];
        NSArray *android = allFSU1[@"Mobility Android"];
//        for (NSDictionary *contact in buLead) {
//            NSLog(@"%@", contact[@"name"]);
//        }

        [dataArray addObject:buLead];
        [dataArray addObject:GeAs];
        [dataArray addObject:iOS];
        [dataArray addObject:android];
    }
    [self.navigationController setNavigationBarHidden:NO];
    NSURL *url =    [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                            pathForResource:@"FSU1" ofType:@"mp4"]];
    self.videoController = [[MPMoviePlayerController alloc] init];
    self.videoController.controlStyle = MPMovieControlStyleFullscreen;
    [self.videoController setContentURL:url];
    [self.videoController.view setFrame:self.view.bounds];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.videoController];
    [self.view addSubview:self.videoController.view];
    [self.videoController prepareToPlay];
    [self.videoController play];
    [self.videoController setFullscreen:YES animated:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopCurrentView) name:@"kNotificationDidLostBeacon" object:nil];
    
}
- (void)stopCurrentView
{
    // Exit current view
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"%lu", (unsigned long)[dataArray count]);
    return [dataArray count];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger noOfRow = 0;
    if(section==0)
    {
        NSArray * buLeaderArr  = [dataArray objectAtIndex:section];

        noOfRow = [buLeaderArr count];
    }
    else if (section==1)
    {
        NSArray * gaArr = [dataArray objectAtIndex:section];

        noOfRow = [gaArr count];
    }
    else if (section==2)
    {
        NSArray * iosDevArr = [dataArray objectAtIndex:section];

        noOfRow = [iosDevArr count];
    }
    else if (section==3)
    {
        NSArray * iosDevArr = [dataArray objectAtIndex:section];
        
        noOfRow = [iosDevArr count];
    }
    
    return noOfRow;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return @"BU Lead";
    }
    else if (section==1){
        return @"General Admin";
    }
    else  if (section==2)
    {
        return @"Mobility iOS";
    }
    else if (section==3)
    {
        return @"Mobility Android";
    }
    else
    {
        return @"Unknown";
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSArray * arr = [dataArray objectAtIndex:indexPath.section];
    NSDictionary * dic = [arr objectAtIndex:indexPath.row];
    
    NSString * name = [dic objectForKey:@"name"];
    NSString * email = [dic objectForKey:@"email"];
    cell.textLabel.text = name;
    cell.detailTextLabel.text = email;
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc]init];
        mc.mailComposeDelegate = self;
        [mc setSubject:@"FTour guess"];
        NSString *a = cell.detailTextLabel.text;
        [mc setToRecipients:[NSArray arrayWithObject:a]];
        [self presentViewController:mc animated:YES completion:NULL];    }
    else
    {
        UIAlertView *aView = [[UIAlertView alloc]initWithTitle:@"Email Setup" message:@"Please set-up your email account before using this function" delegate:nil cancelButtonTitle:@"Got it" otherButtonTitles:nil, nil];
        [aView show];
    }
    cell.selected = FALSE;
    
}
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)videoPlayBackDidFinish:(NSNotification *)notification {
    NSLog(@"Finish");
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [self.videoController stop];
    [self.videoController.view removeFromSuperview];
    self.videoController = nil;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
