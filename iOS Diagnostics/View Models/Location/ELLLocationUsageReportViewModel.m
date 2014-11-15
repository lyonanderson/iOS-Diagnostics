//
//  ELLLocationUsageReportViewModel.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 11/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ELLLocationUsageReportViewModel.h"
#import "ELLLocationUsage.h"
#import "ELLLocationUsageReport.h"

@interface ELLLocationUsageReportViewModel()
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation ELLLocationUsageReportViewModel

- (instancetype)initWithModel:(ELLReportSectionModel *)model reportTitle:(NSString *)reportTitle {
    if (self = [super initWithModel:model reportTitle:reportTitle]) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [_dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    }
    return self;
}


-(NSString *)titleAtIndexPath:(NSIndexPath *)indexPath {
    ELLLocationUsage *locationUsage = [self locationUsageForIndexPath:indexPath];
    return [NSString stringWithFormat:@"%@ to \n%@",
                [self.dateFormatter stringFromDate:locationUsage.timestamp],
                [self.dateFormatter stringFromDate:locationUsage.timestampEnd]];
}

-(NSString *)detailAtIndexPath:(NSIndexPath *)indexPath {
    return @"";
}


#pragma mark Util

- (ELLLocationUsage *)locationUsageForIndexPath:(NSIndexPath *)indexPath {
    return self.results[indexPath.row];
}


@end
