//
//  ELLProcessTime.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 09/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLProcessTime.h"

@interface ELLProcessTime ()
@property (nonatomic, readwrite, copy) NSString *processName;
@property (nonatomic, readwrite, assign) NSTimeInterval processTime;
@end

@implementation ELLProcessTime


- (instancetype)initWithProcessName:(NSString *)processName processTime:(NSTimeInterval)processTime {
    self = [super init];
    if (self) {
        _processName = [processName copy];
        _processTime = processTime;
    }
    return self;
}

+ (instancetype)processTimeWithName:(NSString *)processName processTime:(NSTimeInterval)processTime {
    return [[ELLProcessTime alloc] initWithProcessName:processName processTime:processTime];
}

@end
