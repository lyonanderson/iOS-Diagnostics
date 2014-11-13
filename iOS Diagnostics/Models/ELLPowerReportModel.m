//
//  ELLPowerReportModel.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 08/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLPowerReportModel.h"
#import "ELLPowerLogDownloadService.h"
#import "ELLSqlPowerLogAnalyser.h"


@interface ELLPowerReportModel()<ELLPowerLogDownloadServiceDelegate>
@property (nonatomic, strong) ELLPowerLogDownloadService *powerLogService;

@property (nonatomic, readwrite, assign) BOOL readyToReport;
@property (nonatomic, readwrite, assign) NSUInteger numberOfReports;
@property (nonatomic, readwrite, strong) NSError *loadError;

@property (nonatomic, readwrite, strong) NSArray *reportFiles;
@property (nonatomic, readwrite, strong) NSArray *compressedReportFiles;
@end

@implementation ELLPowerReportModel

- (instancetype)initPowerLogService:(ELLPowerLogDownloadService *)powerLogService {
    self = [super init];
    if (self) {
        _powerLogService = powerLogService;
        _powerLogService.delegate = self;
        _readyToReport = NO;
        [_powerLogService startPowerLogDownload];
    }
    return self;
}

- (NSUInteger) numberOfReports {
    return self.reportFiles.count;
}

- (ELLSqlPowerLogAnalyser *)logAnalyserForReport:(NSUInteger)report {
    return [[ELLSqlPowerLogAnalyser alloc] initWithLogfile:self.reportFiles[report]];
}

- (void)reload {
    self.loadError = nil;
    self.readyToReport = NO;
    [_powerLogService startPowerLogDownload];
}

#pragma mark ELLPowerLogDownloadServiceDelegate

- (void) powerLogDownloadService:(ELLPowerLogDownloadService *)downloadService didFinishWithSQLLogFiles:(NSArray *)sqlLogFiles compressedSQLFiles:(NSArray *)compressedSQLFiles {
    self.reportFiles = sqlLogFiles;
    self.compressedReportFiles = compressedSQLFiles;
    self.readyToReport = YES;
}

- (void) powerLogDownloadService:(ELLPowerLogDownloadService *)downloadService didFailWithError:(NSError *)error {
    self.loadError = error;
    self.readyToReport = NO;
}

@end
