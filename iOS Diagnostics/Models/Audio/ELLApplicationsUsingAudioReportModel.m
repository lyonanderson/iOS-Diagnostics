//
//  ELLApplicationsUsingAudioReportModel.m
//  Diagnostics
//
//  Created by Christopher Anderson on 23/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLApplicationsUsingAudioReportModel.h"
#import "ELLReportSectionModel+Internal.h"
#import "ELLSqlPowerLogAnalyser.h"

@implementation ELLApplicationsUsingAudioReportModel

- (void)load {
    [self.logAnalyser processApplicationsUsingAudioFrom:self.startDate toDate:self.endDate completion:^(NSArray *applicationNames, NSError *error) {
        self.results = applicationNames;
        self.readyToReport = YES;
    }];
}

- (void)filterResults:(NSString *)filterTerm {
    self.readyToReport = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *filteredResults = [NSMutableArray array];
        
        [self.results enumerateObjectsUsingBlock:^(NSString *applicationName, NSUInteger idx, BOOL *stop) {
            if ([applicationName rangeOfString:filterTerm options:NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch].location != NSNotFound) {
                [filteredResults addObject:applicationName];
            }
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.filteredResults = filteredResults;
            self.readyToReport = YES;
        });
        
    });
}

@end
