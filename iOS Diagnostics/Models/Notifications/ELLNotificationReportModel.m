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

@end
