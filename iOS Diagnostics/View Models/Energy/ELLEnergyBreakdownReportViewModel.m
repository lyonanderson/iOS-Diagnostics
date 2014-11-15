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


-(NSString *)titleAtIndexPath:(NSIndexPath *)indexPath {
    return [self energyBreakdownForIndexPath:indexPath].energyKind;
}

-(NSString *)detailAtIndexPath:(NSIndexPath *)indexPath {
    return [NSString stringWithFormat:@"%.2f", [self energyBreakdownForIndexPath:indexPath].energy];
}


#pragma mark Util

- (ELLEnergyBreakdown *)energyBreakdownForIndexPath:(NSIndexPath *)indexPath {
    return self.results[indexPath.row];
}

@end
