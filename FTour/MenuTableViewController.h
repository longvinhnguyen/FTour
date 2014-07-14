//
//  MenuTableViewController.h
//  FTour
//
//  Created by Khanhhoa Mai on 7/9/14.
//  Copyright (c) 2014 FSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenuTableViewController;
@protocol MenuTableViewControllerDelegate <NSObject>

-(void)addItemViewController:(MenuTableViewController *)viewController didFinishPickingItems:(NSMutableArray *)items;

@end

@interface MenuTableViewController : UITableViewController

@property (nonatomic,weak) id<MenuTableViewControllerDelegate> delegate;
@property (nonatomic,strong) NSMutableArray *selectedItems;
@end

