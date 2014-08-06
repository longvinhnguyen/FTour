//

//  MenuTableViewController.m

//  FTour

//

//  Created by Khanhhoa Mai on 7/9/14.

//  Copyright (c) 2014 FSoft. All rights reserved.

//



#import "MenuTableVC.h"
#import "DataService.h"


@interface MenuTableVC ()<UISearchBarDelegate,UISearchDisplayDelegate>{
    
    NSDictionary *allMenuItem;
    
    NSArray *keys;
    
    UISearchBar *searchBar;
    
    UISearchDisplayController *searchDisplayController;
    
    NSMutableDictionary *searchData;
    
    BOOL isFiltered;
    //   NSMutableArray *selectedItems;
    
}



@end



@implementation MenuTableVC

@synthesize delegate;
@synthesize selectedItems;


- (void)viewDidLoad

{
    
    [super viewDidLoad];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    
    // self.clearsSelectionOnViewWillAppear = NO;
    
    
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.navigationController setNavigationBarHidden:NO];
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(didPressDoneButton)];
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(didCancelOrder)];
    
    self.navigationItem.rightBarButtonItem = btn;
    
    self.navigationItem.leftBarButtonItem = cancelBtn;
    
    self.navigationItem.hidesBackButton = YES;
    
    self.navigationItem.title = @"Menu";
    
    [self loadMenu];
    
    searchBar  = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    
    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:searchBar contentsController:self];
    
    searchDisplayController.delegate = self;
    
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
    
    searchBar.delegate  = self;
    
    self.tableView.tableHeaderView = searchBar;
    NSLog(@"%@",selectedItems);

    
    
    
}
- (void)stopCurrentView
{
    NSLog(@"Stop broadcast");
    if ([self.navigationController.viewControllers count] >= 2)
    {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
}

-(void)viewWillAppear:(BOOL)animated
{

    [self.tableView reloadData];
}

-(void)loadMenu {
    allMenuItem = [[DataService sharedInstance] loadFSU1Data];
    if (allMenuItem) {
        keys = [allMenuItem allKeys];
        NSArray *results = [allMenuItem valueForKey:@"Food"];
        for (NSDictionary *item in results) {
            NSLog(@"%@",item);
        }
    }
}




-(void) didPressDoneButton

{

    [self.delegate addItemViewController:self didFinishPickingItems:selectedItems];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}

-(void)didCancelOrder

{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning

{
    
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
    
}



#pragma mark - Table view



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    
    // Return the number of sections.
    
    return isFiltered ? [searchData count] : [keys count];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    
    id key = [keys objectAtIndex:section];
    
    NSArray *arrayAtIndex = [allMenuItem objectForKey:key];
    
    
    
    return isFiltered? [[searchData objectForKey:key] count] : [arrayAtIndex count];
    
    
    
}



-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{
    
    id key = [keys objectAtIndex:section];
    
    //   return [NSString stringWithFormat:@"%@", key];
    
    NSArray *array = [searchData allKeys];
    
    return isFiltered ? [NSString stringWithFormat:@"%@", [array objectAtIndex:section]] : [NSString stringWithFormat:@"%@",key];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    static NSString * CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
    }
    
    
    
    id key = [keys objectAtIndex:indexPath.section];
    
    NSArray *itemArray = [allMenuItem objectForKey:key];
    
    NSDictionary *itemDetail = [itemArray objectAtIndex:indexPath.row];
    
    
    
    cell.textLabel.text = isFiltered ? [[[searchData objectForKey:key] objectAtIndex:indexPath.row] objectForKey:@"name"] : [itemDetail objectForKey:@"name"];
    for (NSDictionary *item in selectedItems) {
        if ([cell.textLabel.text isEqualToString:[item objectForKey:@"Name"]]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    
    NSString *price = isFiltered ? [NSString stringWithFormat:@"%@",[[[searchData objectForKey:key]objectAtIndex:indexPath.row]objectForKey:@"price"]]:[NSString stringWithFormat:@"%@",[itemDetail objectForKey:@"price"]];
    
    cell.detailTextLabel.text = price;

    
    
    return cell;
    
}



#pragma mark - Table view delegate


// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell;
    NSMutableDictionary *selectedItemAtIndexpath = [[NSMutableDictionary alloc]init];
    
    
    cell = [tableView cellForRowAtIndexPath:indexPath];
    if(cell.accessoryType == UITableViewCellAccessoryNone){
        [selectedItemAtIndexpath setValue:cell.textLabel.text forKey:@"Name"];
        [selectedItemAtIndexpath setValue:cell.detailTextLabel.text forKey:@"Price"];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [selectedItems insertObject:selectedItemAtIndexpath atIndex:0];
    }else{
        NSMutableArray *toDelete = [NSMutableArray array];
        for(NSDictionary *item in selectedItems){
            
            if ([[item objectForKey:@"Name"] isEqualToString:cell.textLabel.text]) {
                cell.accessoryType = UITableViewCellAccessoryNone;
                [toDelete addObject:item];
            }
        }
        [selectedItems removeObjectsInArray:toDelete];
    }
    
    
    NSLog(@"%@",selectedItems);
    
    
    
}

-(void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView
{
    for(int section = 0,sectionCount = (int)tableView.numberOfSections; section < sectionCount;section++){
        for(int row = 0;row < [tableView numberOfRowsInSection:section];row++){
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
            for(NSDictionary *item in selectedItems){
                if([cell.textLabel.text isEqualToString:[item objectForKey:@"Name"]]){
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
                else{
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
            }
        }
    }
}


#pragma mark - UISearchBar

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText

{
    
    if(searchText.length ==0){
        
        isFiltered = NO;
        
    }else{
        
        isFiltered = YES;
        
        searchData = [[NSMutableDictionary alloc]init];
        
        for(id key in keys){
            
            NSArray *items = [allMenuItem objectForKey:key];
            
            NSMutableArray *searchedItem = [[NSMutableArray alloc]init];
            
            for(NSDictionary *item in items){
                
                NSRange range = [[item objectForKey:@"name"]rangeOfString:searchText options:NSCaseInsensitiveSearch];
                
                if(range.location != NSNotFound){
                    
                    [searchedItem addObject:item];
                    
                }
                
                
                
            }
            
            if(searchedItem){
                
                [searchData setObject:searchedItem forKey:key];
                
            }
        }
    }
    
    
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
    NSLog(@"entered cancel");
    [self viewWillAppear:YES];
}

@end

