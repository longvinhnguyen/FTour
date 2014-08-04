//
//  MenuTableViewController.h
//  FTour
//
//  Created by Khanhhoa Mai on 7/9/14.
//  Copyright (c) 2014 FSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Food.h"
@class MenuTableVC;
@protocol MenuTableViewControllerDelegate <NSObject>

-(void)addItemViewController:(MenuTableVC *)viewController didFinishPickingItems:(NSMutableArray *)items;

@end

@interface MenuTableVC : UITableViewController

@property (nonatomic,weak) id<MenuTableViewControllerDelegate> delegate;
@property (nonatomic,strong) NSMutableArray *selectedItems;
@end

