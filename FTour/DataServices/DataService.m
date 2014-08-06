//
//  DataService.m
//  FTour
//
//  Created by Tam Ho Van on 8/6/14.
//  Copyright (c) 2014 FSoft. All rights reserved.
//

#import "DataService.h"

@implementation DataService
static NSString *kCafeName = @"MCafe";
static NSString *kFSU1Name = @"FSU1_Data";
static NSString *jsonExt = @"json";

+(DataService *)sharedInstance
{
    static DataService* _sharedInstace = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstace = [[DataService alloc]init];
    });
    return _sharedInstace;
}


#pragma mark -
#pragma mark Public Methods

-(NSDictionary *)loadCafeData {
    __block NSDictionary *result = nil;
    [self getData:kCafeName completion:^(NSDictionary *response) {
        result = response;
    }];
    return result;
    
}

-(NSDictionary *)loadFSU1Data {
    __block NSDictionary *result = nil;
    [self getData:kFSU1Name completion:^(NSDictionary *response) {
        result = response;
    }];
    return result;
}

#pragma mark -
#pragma mark Private Methods
#pragma mark Get Data

-(void)getData:(NSString *)fileName completion:(void(^)(NSDictionary *response))handler {
    NSString *filePath; filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:jsonExt];
    NSData *allFSU1Data = [[NSData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:allFSU1Data options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"ERROR: %@", error.userInfo);
    }
    handler(data);
}


@end
