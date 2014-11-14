//
//  ELLProcessNamesReportModel.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 14/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLProcessNamesReportModel.h"
#import "ELLReportSectionModel+Internal.h"
#import "ELLSqlPowerLogAnalyser.h"

@interface ELLProcessNamesReportModel ()
@property (nonatomic, readwrite, strong) NSArray *processNames;
@end

@implementation ELLProcessNamesReportModel

- (void)load {
    [self.logAnalyser processNamesFrom:self.startDate toDate:self.endDate completion:^(NSArray *processNames, NSError *error) {
        self.processNames = processNames;
        self.readyToReport = YES;
    }];
}

@end
