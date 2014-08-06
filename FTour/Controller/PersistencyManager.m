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
    NSDictionary *allFSU1;
    BOOL success;
}
@end

@implementation PersistencyManager
-(id)init
{
    self = [super init];
    if(self)
    {
        NSString *filePath; filePath = [[NSBundle mainBundle] pathForResource:@"FSU1_Data" ofType:@"json"];
        contacts = [[NSMutableDictionary alloc]init];
        NSData *allFSU1Data = [[NSData alloc] initWithContentsOfFile:filePath];
        NSError *error;
        allFSU1 = [NSJSONSerialization JSONObjectWithData:allFSU1Data options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"data: %@", allFSU1);
        success = (!error)?YES:NO;
        
    }
    return  self;
}

- (NSDictionary *)getContacts {
    if (success) {
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

//- (NSMutableArray*)getBuLeadContacts
//{
//    return [contacts objectAtIndex:1];
//}chaunln
//- (NSMutableArray*)getGeneralAssitantContact
//{
//    return [contacts objectAtIndex:2];
//
//}
//- (NSMutableArray*)getiOSContact
//{
//    return [contacts objectAtIndex:1];
//
//}
//- (NSMutableArray*)getAndroidContact
//{
//    return [contacts objectAtIndex:1];
//
//}
@end
