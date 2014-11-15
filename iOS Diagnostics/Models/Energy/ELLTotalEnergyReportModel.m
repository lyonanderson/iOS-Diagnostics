//
//  ELLTotalEnergyReportModel.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 10/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLTotalEnergyReportModel.h"
#import "ELLReportSectionModel+Internal.h"
#import "ELLSqlPowerLogAnalyser.h"

@interface ELLTotalEnergyReportModel ()
@end

@implementation ELLTotalEnergyReportModel


- (void)load {
    [self.logAnalyser processTotalEnergyFromDate:self.startDate toDate:self.endDate completion:^(NSArray *totalEnergyPerProcess, NSError *error) {
        if (!error) {
            self.results = totalEnergyPerProcess;
            self.readyToReport = YES;
        }
    }];
}


@end
