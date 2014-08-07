//
//  Food.h
//  FTour
//
//  Created by Khanhhoa Mai on 8/4/14.
//  Copyright (c) 2014 FSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Food : NSObject

@property (nonatomic,strong) NSString *fName;
@property (nonatomic,strong) NSString *fPrice;
@property (nonatomic,strong) NSString *imgURL;
-(id)initWithDetail:(NSString*)fName price:(NSString*)fPrice imgURL:(NSString*)imgURL;

@end
