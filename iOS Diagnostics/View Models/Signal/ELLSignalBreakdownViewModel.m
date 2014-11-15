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



-(NSString *)titleAtIndexPath:(NSIndexPath *)indexPath {
    return [NSString stringWithFormat:@"%ld", (long)indexPath.row];
}

-(NSString *)detailAtIndexPath:(NSIndexPath *)indexPath {
    return [NSString stringWithFormat:@"%ld%%", (long)[self.results[indexPath.row] integerValue]];
}

@end
