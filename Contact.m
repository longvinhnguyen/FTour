//
//  Contact.m
//  FTour
//
//  Created by Khanhhoa Mai on 8/4/14.
//  Copyright (c) 2014 FSoft. All rights reserved.
//

#import "Contact.h"

@implementation Contact
-(Contact*)init{
    self = [super init];
    if (self) {
        self.name = _name;
        self.email = _email;
        self.phoneNumber = _phoneNumber;
    }
    return self;
}
@end
