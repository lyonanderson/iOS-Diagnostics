//
//  ELLLocationUsage.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 11/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLLocationUsage.h"

@interface ELLLocationUsage ()
@property (nonatomic, readwrite, copy) NSDate *timestamp;
@property (nonatomic, readwrite, copy) NSDate *timestampEnd;
@end

@implementation ELLLocationUsage

- (instancetype)initWithTimestamp:(NSDate *)timestamp timestampEnd:(NSDate *)timestampEnd {
    self = [super init];
    if (self) {
        _timestamp = [timestamp copy];
        _timestampEnd = [timestampEnd copy];
    }
    return self;
}


+ (instancetype)locationUsageWithTimestamp:(NSDate *)timestamp timestampEnd:(NSDate *)timestampEnd {
    return [[self alloc] initWithTimestamp:timestamp timestampEnd:timestampEnd];
}

@end
