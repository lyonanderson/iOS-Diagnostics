//
//  ELLProcessEvent.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 14/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLProcessEvent.h"

@interface ELLProcessEvent ()
@property (nonatomic, readwrite, copy) NSDate *timestamp;
@property (nonatomic, readwrite, copy) NSString *eventType;
@property (nonatomic, readwrite, assign) double length;
@end

@implementation ELLProcessEvent

- (instancetype)initEventWithTimestamp:(NSDate *)timestamp type:(NSString *)eventType length:(double)length {
    self = [super init];
    if (self) {
        _timestamp = timestamp;
        _eventType = [eventType copy];
        _length = length;
    }
    return self;
}

+ (instancetype)processEventWithTimestamp:(NSDate *)timestamp type:(NSString *)eventType length:(double)length {
    return [[self alloc] initEventWithTimestamp:timestamp type:eventType length:length];
}

@end
