//
//  ELLSignalBreakdownViewModel.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 11/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ELLSignalBreakdownViewModel.h"
#import "ELLSignalBreakdownModel.h"

@implementation ELLSignalBreakdownViewModel


-(NSInteger)numberOfItemsInSection:(NSInteger)section {
    ELLSignalBreakdownModel *energyBreakdown = (ELLSignalBreakdownModel *)self.model;
    return energyBreakdown.signalBarToPercentage.count;
}

-(NSString *)titleAtIndexPath:(NSIndexPath *)indexPath {
    return [NSString stringWithFormat:@"%ld", (long)indexPath.row];
}

-(NSString *)detailAtIndexPath:(NSIndexPath *)indexPath {
    ELLSignalBreakdownModel *energyBreakdown = (ELLSignalBreakdownModel *)self.model;
    return [NSString stringWithFormat:@"%ld%%", (long)[energyBreakdown.signalBarToPercentage[indexPath.row] integerValue]];
}

@end
