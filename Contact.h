//
//  Contact.h
//  FTour
//
//  Created by Khanhhoa Mai on 8/4/14.
//  Copyright (c) 2014 FSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *email;
@property (strong,nonatomic) NSString *phoneNumber;

#pragma Method
-(id)initWithDetail:(NSString*)name email:(NSString*)email phoneNumber:(NSString*)phoneNumber;

@end
