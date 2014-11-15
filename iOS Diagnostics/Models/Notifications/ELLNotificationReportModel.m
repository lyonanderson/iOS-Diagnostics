//
//  ELLNotificationReportModel.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 08/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLNotificationReportModel.h"
#import "ELLReportSectionModel+Internal.h"
#import "ELLSqlPowerLogAnalyser.h"
#import "ELLNotificationCount.h"

@interface ELLNotificationReportModel ()
@end

@implementation ELLNotificationReportModel

- (void)load {
    [self.logAnalyser processNotificationsFrom:self.startDate toDate:self.endDate completion:^(NSArray *notifications, NSError *error) {
        if (!error) {
            self.results = notifications;
            self.readyToReport = YES;
        }
       
    }];
}

- (void)filterResults:(NSString *)filterTerm {
    self.readyToReport = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *filteredResults = [NSMutableArray array];
        
        [self.results enumerateObjectsUsingBlock:^(ELLNotificationCount *notificationCount, NSUInteger idx, BOOL *stop) {
            if ([notificationCount.topic rangeOfString:filterTerm options:NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch].location != NSNotFound) {
                [filteredResults addObject:notificationCount];
            }
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.filteredResults = filteredResults;
            self.readyToReport = YES;
        });
        
    });
}

@end
