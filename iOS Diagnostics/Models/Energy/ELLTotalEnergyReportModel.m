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
#import "ELLTotalEnergyForProcess.h"

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

- (void)filterResults:(NSString *)filterTerm {
    self.readyToReport = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *filteredResults = [NSMutableArray array];
        
        [self.results enumerateObjectsUsingBlock:^(ELLTotalEnergyForProcess *energyForProcess, NSUInteger idx, BOOL *stop) {
            if ([energyForProcess.processName rangeOfString:filterTerm options:NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch].location != NSNotFound) {
                [filteredResults addObject:energyForProcess];
            }
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.filteredResults = filteredResults;
            self.readyToReport = YES;
        });
        
    });
}


@end
