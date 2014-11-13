//
//  ELLEnergyBreakdownReportViewModel.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 10/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELLEnergyBreakdownReportViewModel.h"
#import "ELLEnergyBreakdownReportModel.h"
#import "ELLEnergyBreakdown.h"

@implementation ELLEnergyBreakdownReportViewModel

-(NSInteger)numberOfItemsInSection:(NSInteger)section {
    ELLEnergyBreakdownReportModel *energyBreakdown = (ELLEnergyBreakdownReportModel *)self.model;
    return energyBreakdown.breakdownForProcess.count;
}

-(NSString *)titleAtIndexPath:(NSIndexPath *)indexPath {
    return [self energyBreakdownForIndexPath:indexPath].energyKind;
}

-(NSString *)detailAtIndexPath:(NSIndexPath *)indexPath {
    return [NSString stringWithFormat:@"%.2f", [self energyBreakdownForIndexPath:indexPath].energy];
}


#pragma mark Util

- (ELLEnergyBreakdown *)energyBreakdownForIndexPath:(NSIndexPath *)indexPath {
    ELLEnergyBreakdownReportModel *breakdownReport = (ELLEnergyBreakdownReportModel *)self.model;
    return breakdownReport.breakdownForProcess[indexPath.row];
}

@end
