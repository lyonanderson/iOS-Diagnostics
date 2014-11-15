//
//  ELLLocationReportModel.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 08/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLLocationReportModel.h"
#import "ELLReportSectionModel+Internal.h"
#import "ELLSqlPowerLogAnalyser.h"
#import "ELLLocationCount.h"

@interface ELLLocationReportModel ()
@end

@implementation ELLLocationReportModel

- (void)load {
    [self.logAnalyser processLocationUsesFrom:self.startDate toDate:self.endDate completion:^(NSArray *locationUses, NSError *error) {
        if (!error) {
            self.results = locationUses;
            self.readyToReport = YES;
        }
    }];
}

- (void)filterResults:(NSString *)filterTerm {
    self.readyToReport = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *filteredResults = [NSMutableArray array];
        
        [self.results enumerateObjectsUsingBlock:^(ELLLocationCount *locationCount, NSUInteger idx, BOOL *stop) {
            if ([locationCount.client rangeOfString:filterTerm].location != NSNotFound) {
                [filteredResults addObject:locationCount];
            }
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.filteredResults = filteredResults;
            self.readyToReport = YES;
        });
        
    });
}

@end
