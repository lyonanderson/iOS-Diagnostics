//
//  ELLLocationUsage.h
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 11/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELLLocationUsage : NSObject

@property (nonatomic, readonly, copy) NSDate *timestamp;
@property (nonatomic, readonly, copy) NSDate *timestampEnd;

+ (instancetype)locationUsageWithTimestamp:(NSDate *)timestamp timestampEnd:(NSDate *)timestampEnd;

@end
