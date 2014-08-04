//
//  DataStore.h
//  FTour
//
//  Created by Khanhhoa Mai on 8/4/14.
//  Copyright (c) 2014 FSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataStore : NSObject

+(DataStore *) sharedInstance;
-(void)reset;
@property (nonatomic,strong) NSArray *menuFoodItems;
@property (nonatomic,strong) NSMutableArray *orderedItems;
@property (nonatomic,strong) NSArray *contacts;

@end
