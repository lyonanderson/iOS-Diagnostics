//
//  ELLReportSectionModel.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 08/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLReportSectionModel.h"
#import "ELLSqlPowerLogAnalyser.h"

@interface ELLReportSectionModel()
@property (nonatomic, readwrite, strong) ELLSqlPowerLogAnalyser *logAnalyser;
@property (nonatomic, readwrite, strong) NSDate *startDate;
@property (nonatomic, readwrite, strong) NSDate *endDate;
@property (nonatomic, readwrite, assign) BOOL readyToReport;
@end

@implementation ELLReportSectionModel

- (instancetype)initWithLogAnalyser:(ELLSqlPowerLogAnalyser *)logAnalyser startDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    self = [super init];
    if (self) {
        _logAnalyser = logAnalyser;
        _startDate = startDate;
        _endDate = endDate;
    }
    return self;
}

-(void)load {
    @throw [NSError errorWithDomain:@"com.electriclabs.PowerLog" code:404 userInfo:nil];
}

- (void)setReadyToReport:(BOOL)readyToReport {
    _readyToReport = readyToReport;
}

@end
