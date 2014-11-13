//
//  ELLTotalEnergyForProcess.h
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 10/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ELLReportSectionViewModel.h"

@interface ELLTotalEnergyForProcess : ELLReportSectionViewModel

@property (nonatomic, readonly, copy) NSString *processName;
@property (nonatomic, readonly, assign) CGFloat totalEnergy;

+ (instancetype)totalEnergyWithProcessName:(NSString *)processName totalEnergy:(double)totalEnergy;

@end
