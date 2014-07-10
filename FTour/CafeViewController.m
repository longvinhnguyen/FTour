//
//  CafeViewController.m
//  FTour
//
//  Created by Khanhhoa Mai on 7/8/14.
//  Copyright (c) 2014 FSoft. All rights reserved.
//

#import "CafeViewController.h"
#import "MenuTableViewController.h"

@interface CafeViewController () <MenuTableViewControllerDelegate>
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
    NSLog(@"%@",items);
}

@end
