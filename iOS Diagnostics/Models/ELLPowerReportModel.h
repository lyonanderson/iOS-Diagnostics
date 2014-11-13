//
//  ELLPowerReportModel.h
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 08/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ELLPowerLogDownloadService;
@class ELLSqlPowerLogAnalyser;

@interface ELLPowerReportModel : NSObject

@property (nonatomic, readonly, assign) BOOL readyToReport;
@property (nonatomic, readonly, assign) NSUInteger numberOfReports;
@property (nonatomic, readonly, strong) NSArray *reportFiles;
@property (nonatomic, readonly, strong) NSArray *compressedReportFiles;
@property (nonatomic, readonly, strong) NSError *loadError;

- (instancetype)initPowerLogService:(ELLPowerLogDownloadService *)powerLogService;

- (ELLSqlPowerLogAnalyser *)logAnalyserForReport:(NSUInteger)report;
- (void)reload;


@end
