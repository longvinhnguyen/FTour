//
//  PersistencyManager.m
//  FTour
//
//  Created by Tuan An on 04/08/2014.
//  Copyright (c) Năm 2014 FSoft. All rights reserved.
//

#import "PersistencyManager.h"
#import "DataService.h"
@interface PersistencyManager()
{
    NSMutableDictionary *contacts;
    NSMutableDictionary *dishes;
    NSDictionary *allFSU1;
    NSDictionary *allDishes;
}
@end

@implementation PersistencyManager
-(id)init
{
    self = [super init];
    if(self)
    {
        contacts = [[NSMutableDictionary alloc]init];
        dishes = [[NSMutableDictionary alloc]init];
        allFSU1 = [[DataService sharedInstance] loadFSU1Data];
        allDishes = [[DataService sharedInstance] loadCafeData];
    }
    return  self;
}

- (NSDictionary *)getContacts {
    if (allFSU1) {
        NSArray *allFSU1Key = [allFSU1 allKeys];
        for (NSString *key in allFSU1Key)
        {
            NSArray *team = [allFSU1 objectForKey:key];
            NSMutableArray *arrTeamContacs = [[NSMutableArray alloc]init];;
            for (int i =0; i<team.count; i++)
            {
                NSDictionary *personDic = [team objectAtIndex:i];
                Contact *person = [[Contact alloc]initWithDetail:[personDic objectForKey:@"name"] email:[personDic objectForKey:@"email"] phoneNumber:[personDic objectForKey:@"tel"]];
                
                [arrTeamContacs addObject:person];
            }
            [contacts setObject:arrTeamContacs forKey:key];
        }
    }
    return contacts;
}
- (NSDictionary *)getDishes {
    if (allDishes) {
        NSArray *allDishesKey = [allDishes allKeys];
        for (NSString *key in allDishesKey)
        {
            NSArray *section = [allDishes objectForKey:key];
            NSMutableArray *arrDishesSection = [[NSMutableArray alloc]init];;
            for (int i =0; i<section.count; i++)
            {
                NSDictionary *dishDic = [section objectAtIndex:i];
                Food *dish = [[Food alloc]initWithDetail:[dishDic objectForKey:@"name"] price:[dishDic objectForKey:@"price"]  imgURL:[dishDic objectForKey:@"image"]];
                
                [arrDishesSection addObject:dish];
            }
            [dishes setObject:arrDishesSection forKey:key];
        }
    }
    return dishes;
}

@end
