//
//  ELLReportSectionModel.h
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 08/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ELLSqlPowerLogAnalyser;

@interface ELLReportSectionModel : NSObject

@property (nonatomic, readonly, strong) ELLSqlPowerLogAnalyser *logAnalyser;
@property (nonatomic, readonly, strong) NSDate *startDate;
@property (nonatomic, readonly, strong) NSDate *endDate;
@property (nonatomic, readonly, assign) BOOL readyToReport;

- (instancetype)initWithLogAnalyser:(ELLSqlPowerLogAnalyser *)logAnalyser startDate:(NSDate *)startDate endDate:(NSDate *)endDate;
- (void)load;

- (void)filterResults:(NSString *)filterTerm;
- (void)clearFilter;

@end
