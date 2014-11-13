//
//  ELLEnergyBreakdown.h
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 10/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ELLEnergyBreakdown : NSObject

@property (nonatomic, readonly, copy) NSString *energyKind;
@property (nonatomic, readonly, assign) CGFloat energy;

+ (instancetype)energyBreakdownWithKind:(NSString *)kind energy:(CGFloat)energy;

@end
