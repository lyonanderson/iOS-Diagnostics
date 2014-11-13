//
//  ELLOverallReportViewModel.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 12/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ELLOverallReportViewModel.h"
#import "ELLReportSectionViewModel+Internal.h"
#import "ELLOverallReportModel.h"
#import "ELLBatteryChartDataSource.h"


@interface ELLOverallReportViewModel ()
@property (nonatomic, strong) NSDateComponentsFormatter *dateComponentsFormatter;
@end


@implementation ELLOverallReportViewModel

- (instancetype)initWithModel:(ELLReportSectionModel *)model reportTitle:(NSString *)reportTitle {
    if (self = [super initWithModel:model reportTitle:reportTitle]) {
        _dateComponentsFormatter = [[NSDateComponentsFormatter alloc] init];
        _dateComponentsFormatter.zeroFormattingBehavior = NSDateComponentsFormatterZeroFormattingBehaviorDropAll;
        _dateComponentsFormatter.unitsStyle = NSDateComponentsFormatterUnitsStyleAbbreviated;
        _dateComponentsFormatter.allowedUnits = (kCFCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond);
    }
    return self;
}


-(NSInteger)numberOfItemsInSection:(NSInteger)section {
    return 2;
}

-(NSString *)titleAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return @"Total On Time";
    } else {
        return @"Total Display On Time";
    }
}

-(NSString *)detailAtIndexPath:(NSIndexPath *)indexPath {
    ELLOverallReportModel *overallReportModel = (ELLOverallReportModel *)self.model;
    if (indexPath.row == 0) {
        return [_dateComponentsFormatter stringFromTimeInterval:overallReportModel.totalOnTime];
    } else {
        return [_dateComponentsFormatter stringFromTimeInterval:overallReportModel.totalDisplayOnTime];
    }
}

#pragma mark Charts

-(void)generateChartDataSource {
    ELLOverallReportModel *overallReportModel = (ELLOverallReportModel *)self.model;
    ELLBatteryChartDataSource *chartDataSource = [[ELLBatteryChartDataSource alloc] initWithBatteryDates:overallReportModel.batteryDates
                                                                                           batteryValues:overallReportModel.batterValues];
    self.chartDataSource = chartDataSource;
}

@end
