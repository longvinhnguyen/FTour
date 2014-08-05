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
    NSMutableArray *contacts;
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
            NSArray *allFSU1Key = [allFSU1 allKeys];
            for (NSString *key in allFSU1Key)
            {
                NSArray *team = [allFSU1 objectForKey:key];
                for (int i =0; i<team.count; i++)
                {
                    NSDictionary *personDic = [team objectAtIndex:i];
                    Contact *person = [[Contact alloc]initWithDetail:[personDic objectForKey:@"name"] email:[personDic objectForKey:@"email"] phoneNumber:[personDic objectForKey:@"tel"]];
                    [contacts addObject:person];
                }
            }
        }
    }
    return  self;
}
- (NSMutableArray*)getContacts
    {
        return contacts;
    }
- (NSMutableArray*)getBuLeadContacts
{
    return [contacts objectAtIndex:1];
}
- (NSMutableArray*)getGeneralAssitantContact
{
    return [contacts objectAtIndex:2];

}
- (NSMutableArray*)getiOSContact
{
    return [contacts objectAtIndex:1];

}
- (NSMutableArray*)getAndroidContact
{
    return [contacts objectAtIndex:1];

}
@end
