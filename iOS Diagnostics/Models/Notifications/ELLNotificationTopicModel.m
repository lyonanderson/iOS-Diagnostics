//
//  ELLNotificationTopicModel.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 10/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLNotificationTopicModel.h"
#import "ELLReportSectionModel+Internal.h"
#import "ELLSqlPowerLogAnalyser.h"

@interface ELLNotificationTopicModel ()
@property (nonatomic, readwrite, copy) NSString *topic;
@end

@implementation ELLNotificationTopicModel

- (instancetype)initWithLogAnalyser:(ELLSqlPowerLogAnalyser *)logAnalyser startDate:(NSDate *)startDate endDate:(NSDate *)endDate topic:(NSString *)topic {
    self = [super initWithLogAnalyser:logAnalyser startDate:startDate endDate:endDate];
    if (self) {
        _topic = [topic copy];
    }
    return self;
}

- (void)load {
    [self.logAnalyser processNotificationsFrom:self.startDate toDate:self.endDate topic:self.topic completion:^(NSArray *notifications, NSError *error) {
        if (!error) {
            self.results = notifications;
            self.readyToReport = YES;
        }
    }];
}

@end
