//
//  FSU1ViewController.m
//  FTour
//
//  Created by Khanhhoa Mai on 7/8/14.
//  Copyright (c) 2014 FSoft. All rights reserved.
//
//

#import "FSU1ViewController.h"

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
    NSString * cellValue = [NSString stringWithFormat:@"%@",name];
    cell.textLabel.text =cellValue;
    
    return cell;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
