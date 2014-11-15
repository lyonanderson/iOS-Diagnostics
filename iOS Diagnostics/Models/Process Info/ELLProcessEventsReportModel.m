//
//  ELLProcessEventsReportModel.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 14/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLProcessEventsReportModel.h"
#import "ELLReportSectionModel+Internal.h"
#import "ELLSqlPowerLogAnalyser.h"

@interface ELLProcessEventsReportModel ()
@property (nonatomic, readwrite, copy) NSString *processName;
@end

@implementation ELLProcessEventsReportModel

- (instancetype)initWithLogAnalyser:(ELLSqlPowerLogAnalyser *)logAnalyser startDate:(NSDate *)startDate endDate:(NSDate *)endDate processName:(NSString *)processName {
    if (self = [super initWithLogAnalyser:logAnalyser startDate:startDate endDate:endDate]){
        _processName = [processName copy];
    }
    return self;
}

- (void)load {
    [self.logAnalyser processInfoFrom:self.startDate toDate:self.endDate processName:self.processName completion:^(NSArray *processEvents, NSError *error) {
        self.results = processEvents;
        self.readyToReport = YES;
    }];
}

@end
