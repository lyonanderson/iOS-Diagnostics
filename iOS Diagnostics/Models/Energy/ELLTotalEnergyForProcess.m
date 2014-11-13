//
//  ELLTotalEnergyForProcess.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 10/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//


#import "ELLTotalEnergyForProcess.h"

@interface ELLTotalEnergyForProcess ()
@property (nonatomic, readwrite, copy) NSString *processName;
@property (nonatomic, readwrite, assign) CGFloat totalEnergy;
@end

@implementation ELLTotalEnergyForProcess

- (instancetype)initWithProcessName:(NSString *)processName totalEnergy:(double)totalEnergy {
    self = [super init];
    if (self) {
        _processName = [processName copy];
        _totalEnergy = totalEnergy;
    }
    return self;
}

+ (instancetype)totalEnergyWithProcessName:(NSString *)processName totalEnergy:(double)totalEnergy {
    return [[self alloc] initWithProcessName:processName totalEnergy:totalEnergy];
}

@end
