//
//  ELLLocationUsageReport.h
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 11/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLReportSectionModel.h"

@interface ELLLocationUsageReport : ELLReportSectionModel

@property (nonatomic, readonly, strong) NSString *bundle;

- (instancetype)initWithLogAnalyser:(ELLSqlPowerLogAnalyser *)logAnalyser startDate:(NSDate *)startDate endDate:(NSDate *)endDate bundle:(NSString *)bundle;

@end
