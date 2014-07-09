//
//  MenuTableViewController.m
//  FTour
//
//  Created by Khanhhoa Mai on 7/9/14.
//  Copyright (c) 2014 FSoft. All rights reserved.
//

#import "MenuTableViewController.h"

@interface MenuTableViewController (){
    NSMutableDictionary *allMenuItem;
    NSArray *keys;
}

@end

@implementation MenuTableViewController

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
    [self loadMenu];
  //  NSLog(@"All Item : %lu",(unsigned long)[allMenuItem count]);
}

-(void)loadMenu
{
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"MCafe" ofType:@"json"];
    NSData *allMenuItemData = [[NSData alloc]initWithContentsOfFile:filePath];
    NSError *error;
    allMenuItem = [NSJSONSerialization JSONObjectWithData:allMenuItemData options:NSJSONReadingMutableContainers error:&error];
    if(error)
    {
        NSLog(@"%@", [error description]);
    }
    else{
        keys = [allMenuItem allKeys];
        NSLog(@"Loaded menu items successfully");
    }
}

-(void) didPressDoneButton
{
    NSArray *selectedItems = [self.tableView indexPathsForSelectedRows];
    NSMutableArray *orderItems = [[NSMutableArray alloc]init];
    for(NSIndexPath *indexPath in selectedItems){
        
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        NSDictionary *item = [[NSDictionary alloc]initWithObjects:@[cell.textLabel.text,cell.detailTextLabel.text] forKeys:@[@"Name",@"Price"]];
        [orderItems insertObject:item atIndex:0];
        
    }
    
    NSLog(@"%@",orderItems);
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    id key = [keys objectAtIndex:section];
    NSArray *arrayAtIndex = [allMenuItem objectForKey:key];
    return [arrayAtIndex count];

}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    id key = [keys objectAtIndex:section];
    return [NSString stringWithFormat:@"%@", key];
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
    cell.textLabel.text = [itemDetail objectForKey:@"name"];
    NSString *price = [NSString stringWithFormat:@"%@",[itemDetail objectForKey:@"price"]];
    cell.detailTextLabel.text = price;
    
    
    
    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
//    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
//    
//    // Pass the selected object to the new view controller.
//    
//    // Push the view controller.
//    [self.navigationController pushViewController:detailViewController animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
}
@end
