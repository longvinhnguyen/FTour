//
//  Contact.m
//  FTour
//
//  Created by Khanhhoa Mai on 8/4/14.
//  Copyright (c) 2014 FSoft. All rights reserved.
//

#import "Contact.h"

@implementation Contact
-(id)initWithDetail:(NSString*)name email:(NSString*)email phoneNumber:(NSString*)phoneNumber{
    self = [super init];
    if(self)
    {
        _name = name;
        _phoneNumber = phoneNumber;
        _email = email;
    }
    return self;
}
@end
