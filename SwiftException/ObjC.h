//
//  ObjC.h
//  SwiftException
//
//  Created by Zsolt Kovacs on 25.10.19.
//  Copyright © 2019 Zsolt Kovacs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ObjC : NSObject

+ (BOOL)catchException:(__attribute__((noescape)) void(^)(void))tryBlock error:(__autoreleasing NSError **)error;

@end

NS_ASSUME_NONNULL_END
