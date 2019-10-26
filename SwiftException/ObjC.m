//
//  ObjC.m
//  SwiftException
//
//  Created by Zsolt Kovacs on 25.10.19.
//  Copyright © 2019 Zsolt Kovacs. All rights reserved.
//

#import "ObjC.h"

@implementation ObjC

+ (BOOL)catchException:(__attribute__((noescape)) void(^)(void))tryBlock error:(__autoreleasing NSError **)error; {
    @try {
        tryBlock();
        return YES;
    }
    @catch (NSException *exception) {
        *error = [[NSError alloc] initWithDomain:exception.name code:0 userInfo:exception.userInfo];
        return NO;
    }
}

@end
