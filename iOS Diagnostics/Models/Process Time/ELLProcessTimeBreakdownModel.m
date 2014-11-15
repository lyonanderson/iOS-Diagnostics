//
//  ELLProcessTimeBreakdownModel.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 09/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLProcessTimeBreakdownModel.h"
#import "ELLReportSectionModel+Internal.h"
#import "ELLSqlPowerLogAnalyser.h"
#import "ELLProcessTime.h"


@interface ELLProcessTimeBreakdownModel ()
@end

@implementation ELLProcessTimeBreakdownModel

- (void)load {
    [self.logAnalyser processProcessTimeBreakdownFrom:self.startDate toDate:self.endDate completion:^(NSArray *processTimeBreakdown, NSError *error) {
        self.results = processTimeBreakdown;
        self.readyToReport = YES;
    }];
}

- (void)filterResults:(NSString *)filterTerm {
    self.readyToReport = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *filteredResults = [NSMutableArray array];
        
        [self.results enumerateObjectsUsingBlock:^(ELLProcessTime *processTime, NSUInteger idx, BOOL *stop) {
            if ([processTime.processName rangeOfString:filterTerm options:NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch].location != NSNotFound) {
                [filteredResults addObject:processTime];
            }
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.filteredResults = filteredResults;
            self.readyToReport = YES;
        });
        
    });
}

@end
