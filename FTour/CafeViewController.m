//
//  CafeViewController.m
//  FTour
//
//  Created by Khanhhoa Mai on 7/8/14.
//  Copyright (c) 2014 FSoft. All rights reserved.
//

#import "CafeViewController.h"
#import "MenuTableViewController.h"

@interface CafeViewController () <MenuTableViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *orderItems;
    int total;
}
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopCurrentView) name:@"kNotificationDidLostBeacon" object:nil];
}
- (void)stopCurrentView
{
    // Exit current view
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(toMenuView)];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:nil];
    if(orderItems.count != 0){
        
        self.navigationItem.rightBarButtonItems = @[btn,barBtn];
    }else{
        self.navigationItem.rightBarButtonItems = @[barBtn];
    }
}



-(void)toMenuView
{
    MenuTableViewController *vc = [[MenuTableViewController alloc] initWithNibName:@"MenuTableViewController" bundle:nil];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addItemViewController:(MenuTableViewController *)viewController didFinishPickingItems:(NSMutableArray *)items
{
    
    orderItems = [NSMutableArray arrayWithArray:items];
    total = 0;
    [self.orderTbl reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return orderItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    NSDictionary *item = [orderItems objectAtIndex:indexPath.row];
    total += [[item objectForKey:@"Price"] intValue];
    
    cell.textLabel.text = [item objectForKey:@"Name"];
    cell.detailTextLabel.text = [item objectForKey:@"Price"];
    
    return cell;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(orderItems.count == 0){
        return nil;
    }
    else{
        
        UITableViewCell *footer = [self.orderTbl dequeueReusableCellWithIdentifier:@"Cell"];
        if (footer == nil) {
            footer = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        }
        footer.detailTextLabel.text = [NSString stringWithFormat:@"Total : %i",total];
        NSLog(@"%i",total);
        footer.backgroundColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
        footer.detailTextLabel.textColor = [UIColor whiteColor];
        return footer;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(orderItems.count ==0){
        return 0;
    }else{
        return 40;
    }
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [orderItems removeObjectAtIndex:indexPath.row];
        total = 0;
        [self.orderTbl reloadData];
        
    }
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

