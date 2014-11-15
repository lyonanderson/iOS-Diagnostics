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

@end

@implementation ELLProcessNamesReportModel

- (void)load {
    [self.logAnalyser processNamesFrom:self.startDate toDate:self.endDate completion:^(NSArray *processNames, NSError *error) {
        self.results = processNames;
        self.readyToReport = YES;
    }];
}

- (void)filterResults:(NSString *)filterTerm {
    self.readyToReport = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *filteredResults = [NSMutableArray array];
        
        [self.results enumerateObjectsUsingBlock:^(NSString *processName, NSUInteger idx, BOOL *stop) {
            if ([processName rangeOfString:filterTerm options:NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch].location != NSNotFound) {
                [filteredResults addObject:processName];
            }
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.filteredResults = filteredResults;
            self.readyToReport = YES;
        });
        
    });
}



@end
