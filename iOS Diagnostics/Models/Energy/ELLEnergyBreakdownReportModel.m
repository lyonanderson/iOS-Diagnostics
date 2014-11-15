//
//  ELLEnergyBreakdownReportModel.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 10/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLEnergyBreakdownReportModel.h"
#import "ELLReportSectionModel+Internal.h"
#import "ELLSqlPowerLogAnalyser.h"


@interface ELLEnergyBreakdownReportModel ()
@property (nonatomic, readwrite, copy) NSString *processName;
@end

@implementation ELLEnergyBreakdownReportModel

- (instancetype)initWithLogAnalyser:(ELLSqlPowerLogAnalyser *)logAnalyser startDate:(NSDate *)startDate endDate:(NSDate *)endDate processName:(NSString *)processName {
    if (self = [super initWithLogAnalyser:logAnalyser startDate:startDate endDate:endDate]) {
        _processName = [processName copy];
    }
    return self;
}

- (void)load {
    [self.logAnalyser processEnergyBreakdownFromDate:self.startDate toDate:self.endDate processName:self.processName completion:^(NSArray *breakdownForProcess, NSError *error) {
        self.results = breakdownForProcess;
        self.readyToReport = YES;
    }];
}


@end
