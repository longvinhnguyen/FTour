//
//  DataStore.m
//  FTour
//
//  Created by Khanhhoa Mai on 8/4/14.
//  Copyright (c) 2014 FSoft. All rights reserved.
//

#import "DataStore.h"

@implementation DataStore

+(DataStore *)sharedInstance
{
    static DataStore* _sharedInstace = nil;
    static dispatch_once_t *oncePredicate;
    
    dispatch_once(oncePredicate, ^{
        _sharedInstace = [[DataStore alloc]init];
    });
    return _sharedInstace;
}

-(id)init
{
    self = [super init];
    if (self) {
        _menuFoodItems = [[NSArray alloc]init];
        _orderedItems = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)reset
{
    [_orderedItems removeAllObjects];
}

@end
