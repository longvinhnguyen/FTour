//
//  PersistencyManager.m
//  FTour
//
//  Created by Tuan An on 04/08/2014.
//  Copyright (c) Năm 2014 FSoft. All rights reserved.
//

#import "PersistencyManager.h"
@interface PersistencyManager()
{
    NSMutableDictionary *contacts;
}
@end

@implementation PersistencyManager
-(id)init
{
    self = [super init];
    if(self)
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"FSU1_Data" ofType:@"json"];
        NSData *allFSU1Data = [[NSData alloc] initWithContentsOfFile:filePath];
        NSError *error;
        NSDictionary *allFSU1 = [NSJSONSerialization JSONObjectWithData:allFSU1Data options:NSJSONReadingMutableContainers error:&error];
        if (error)
        {
            NSLog(@"%@", [error localizedDescription]);
        }
        else
        {
            contacts = [[NSMutableDictionary alloc]init];
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
    }
    return  self;
}
- (NSMutableDictionary*)getContacts
    {
        return contacts;
    }
@end
