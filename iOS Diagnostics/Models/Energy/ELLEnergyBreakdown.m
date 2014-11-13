//
//  ELLEnergyBreakdown.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 10/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLEnergyBreakdown.h"

@interface ELLEnergyBreakdown ()
@property (nonatomic, readwrite, copy) NSString *energyKind;
@property (nonatomic, readwrite, assign) CGFloat energy;
@end

@implementation ELLEnergyBreakdown

- (instancetype)initWithEnergyKind:(NSString *)energyKind energy:(CGFloat)energy {
    self = [super init];
    if (self) {
        _energyKind = [energyKind copy];
        _energy = energy;
    }
    return self;
}

+ (instancetype)energyBreakdownWithKind:(NSString *)kind energy:(CGFloat)energy {
    return [[self alloc] initWithEnergyKind:kind energy:energy];
}


@end
