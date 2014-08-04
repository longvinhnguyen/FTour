//
//  AppDelegate.h
//  FTour
//
//  Created by LongNV on 7/7/14.
//  Copyright (c) 2014 FSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) BaseViewController *mainController;
@property (nonatomic,strong) UINavigationController *navController;

@end
