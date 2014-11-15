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
@property (nonatomic, readwrite, strong) NSArray *filteredProcessNames;
@end

@implementation ELLProcessNamesReportModel

- (void)load {
    [self.logAnalyser processNamesFrom:self.startDate toDate:self.endDate completion:^(NSArray *processNames, NSError *error) {
        self.processNames = processNames;
        self.readyToReport = YES;
    }];
}

- (void)filterResults:(NSString *)filterTerm {
    self.readyToReport = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *filteredProcessNames = [NSMutableArray array];
        
        [self.processNames enumerateObjectsUsingBlock:^(NSString *processName, NSUInteger idx, BOOL *stop) {
            if ([processName rangeOfString:filterTerm].location != NSNotFound) {
                [filteredProcessNames addObject:processName];
            }
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.filteredProcessNames = filteredProcessNames;
            self.readyToReport = YES;
        });
        
    });
}

- (void)clearFilter {
    
}


@end
