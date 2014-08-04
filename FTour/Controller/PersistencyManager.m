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
        contacts = [[NSMutableArray alloc]init];
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
            NSArray * buLead = [allFSU1 objectForKey:@"BU Lead"];
            NSArray *GeAs = allFSU1[@"General Assistant"];
            NSArray *iOS = allFSU1[@"Mobility iOS"];
            NSArray *android = allFSU1[@"Mobility Android"];
            [contacts addObject:buLead];
            [contacts addObject:GeAs];
            [contacts addObject:iOS];
            [contacts addObject:android];
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
