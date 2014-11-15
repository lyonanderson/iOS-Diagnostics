//
//  ELLProcessTimeBreakdownViewModel.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 09/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLProcessTimeBreakdownViewModel.h"
#import "ELLProcessTimeBreakdownModel.h"
#import "ELLProcessTime.h"

@interface ELLProcessTimeBreakdownViewModel ()
@property (nonatomic, strong) NSDateComponentsFormatter *dateComponentsFormatter;
@end

@implementation ELLProcessTimeBreakdownViewModel

- (instancetype)initWithModel:(ELLReportSectionModel *)model reportTitle:(NSString *)reportTitle {
    if (self = [super initWithModel:model reportTitle:reportTitle]) {
        _dateComponentsFormatter = [[NSDateComponentsFormatter alloc] init];
        _dateComponentsFormatter.zeroFormattingBehavior = NSDateComponentsFormatterZeroFormattingBehaviorDropAll;
        _dateComponentsFormatter.unitsStyle = NSDateComponentsFormatterUnitsStyleAbbreviated;
        _dateComponentsFormatter.allowedUnits = (kCFCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond);
    }
    return self;
}

-(NSString *)titleAtIndexPath:(NSIndexPath *)indexPath {
    ELLProcessTime *processTime = [self processTimeForIndexPath:indexPath];
    return processTime.processName;
}

-(NSString *)detailAtIndexPath:(NSIndexPath *)indexPath {
    return [_dateComponentsFormatter stringFromTimeInterval:[self processTimeForIndexPath:indexPath].processTime];
}

#pragma mark Util

- (ELLProcessTime *)processTimeForIndexPath:(NSIndexPath *)indexPath {
    return self.results[indexPath.row];
}


@end
