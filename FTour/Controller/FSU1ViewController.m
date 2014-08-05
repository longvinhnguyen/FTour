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
#import "FSU1DetailViewController.h"
#import "Contact.h"
#import "PersistencyManager.h"

@interface FSU1ViewController ()
{
    NSMutableDictionary *dicContacts;
}
@end

@implementation FSU1ViewController
PersistencyManager *pM;

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
    pM = [[PersistencyManager alloc]init];
    dicContacts = [[NSMutableDictionary alloc]init];
    dicContacts = [pM getContacts];
    [self.navigationController setNavigationBarHidden:YES];
    NSURL *url =    [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                            pathForResource:@"FSU1720R" ofType:@"mov"]];
    self.videoController = [[MPMoviePlayerController alloc] init];
    self.videoController.controlStyle = MPMovieControlStyleFullscreen;
    [self.videoController setContentURL:url];
    [self.videoController.view setFrame:self.view.bounds];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.videoController];
    [self.view addSubview:self.videoController.view];
    self.videoController.controlStyle = MPMovieControlStyleNone;
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

#pragma mark - UITableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [dicContacts count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *keys = [dicContacts allKeys];
    NSInteger noOfRow = [[dicContacts objectForKey:[keys objectAtIndex:section]] count];
    return noOfRow;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *keys = [dicContacts allKeys];
    NSString *sectionTitle =  [keys objectAtIndex:section];
    return sectionTitle;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *keys = [dicContacts allKeys];
    Contact *person = [[Contact alloc]init];
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSArray * arr = [dicContacts objectForKey:[keys objectAtIndex:indexPath.section]];
    person = [arr objectAtIndex:indexPath.row];
    cell.textLabel.text = person.name;
    cell.detailTextLabel.text = person.email;
    return cell;    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Contact *person = [[Contact alloc]init];
    NSArray *keys = [dicContacts allKeys];
    NSArray * arr = [dicContacts objectForKey:[keys objectAtIndex:indexPath.section]];
    person = [arr objectAtIndex:indexPath.row];
    FSU1DetailViewController *fsu1DetailView = [[FSU1DetailViewController alloc]initWithNibName:@"FSU1DetailViewController" bundle:nil];
    [fsu1DetailView setDetailContact:person];
    [[self navigationController]pushViewController:fsu1DetailView animated:YES];
    [mainTable deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - Mail Compose

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
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
