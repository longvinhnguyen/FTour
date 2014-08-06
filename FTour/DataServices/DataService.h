//
//  DataService.h
//  FTour
//
//  Created by Tam Ho Van on 8/6/14.
//  Copyright (c) 2014 FSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataService : NSObject {
 
}

+(DataService *)sharedInstance;
-(NSDictionary *)loadCafeData;
-(NSDictionary *)loadFSU1Data;

@end
