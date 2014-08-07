//
//  Food.m
//  FTour
//
//  Created by Khanhhoa Mai on 8/4/14.
//  Copyright (c) 2014 FSoft. All rights reserved.
//

#import "Food.h"

@implementation Food
-(id)initWithDetail:(NSString *)fName price:(NSString *)fPrice imgURL:(NSString *)imgURL
{
    self = [super init];
    if (self) {
        _fName = fName;
        _fPrice = fPrice;
        _imgURL = imgURL;
    }
    return self;
}
@end
