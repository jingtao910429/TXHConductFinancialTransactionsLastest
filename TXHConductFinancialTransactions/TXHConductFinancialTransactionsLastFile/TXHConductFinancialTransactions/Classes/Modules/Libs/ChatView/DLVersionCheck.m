//
//  DLVersionCheck.m
//  Classes
//
//  Created by Marcel Ruegenberg on 13.06.11.
//  Copyright 2011 Dustlab. All rights reserved.
//

#import "DLVersionCheck.h"
#import <UIKit/UIKit.h>

NSInteger majorOSVersion() {
    static NSInteger osVersion = -1;
    if(osVersion < 0) {
        NSString *v = [[UIDevice currentDevice] systemVersion];
        NSArray *c = [v componentsSeparatedByString:@"."];
        if([c count] > 0) osVersion = [[c objectAtIndex:0] integerValue];
    }
    return osVersion;
}

NSInteger minorOSVersion() {
    static NSInteger osVersion = -1;
    if(osVersion < 0) {
        NSString *v = [[UIDevice currentDevice] systemVersion];
        NSArray *c = [v componentsSeparatedByString:@"."];
        if([c count] > 1) osVersion = [[c objectAtIndex:1] integerValue];
    }
    return osVersion;
}
