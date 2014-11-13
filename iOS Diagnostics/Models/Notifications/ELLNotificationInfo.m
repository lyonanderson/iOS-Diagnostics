//
//  ELLNotificationInfo.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 10/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLNotificationInfo.h"

@interface ELLNotificationInfo ()
@property (nonatomic, readwrite, copy) NSString *connectionType;
@property (nonatomic, readwrite, assign) NSDate *timestamp;
@end

@implementation ELLNotificationInfo


- (instancetype)initWithConnectionType:(NSString *)connectionType timestamp:(NSDate *)timestamp {
    self = [super init];
    if (self) {
        self.connectionType = connectionType;
        self.timestamp = timestamp;
    }

    return self;
}

+ (instancetype)infoWithConnectionType:(NSString *)connectionType timestamp:(NSDate *)timestamp {
    return [[self alloc] initWithConnectionType:connectionType timestamp:timestamp];
}

@end

