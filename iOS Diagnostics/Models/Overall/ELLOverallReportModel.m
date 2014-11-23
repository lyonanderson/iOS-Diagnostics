//
//  ELLOverallReportModel.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 12/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLOverallReportModel.h"
#import "ELLReportSectionModel+Internal.h"
#import "ELLSqlPowerLogAnalyser.h"

@interface ELLOverallReportModel ()
@property (nonatomic, readwrite, assign) NSTimeInterval totalOnTime;
@property (nonatomic, readwrite, assign) NSTimeInterval totalDisplayOnTime;
@property (nonatomic, readwrite, assign) NSTimeInterval totalAudioTime;
@property (nonatomic, readwrite, strong) NSArray *batteryDates;
@property (nonatomic, readwrite, strong) NSArray *batterValues;
@end

@implementation ELLOverallReportModel

- (void)load {
    dispatch_group_t group =  dispatch_group_create();
    
    dispatch_group_enter(group);
    [self.logAnalyser inferOnTimeFrom:self.startDate toDate:self.endDate completion:^(NSTimeInterval timeInterval, NSError *error) {
        self.totalOnTime = timeInterval;
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [self.logAnalyser inferDisplayOnTimeFrom:self.startDate toDate:self.endDate WithCompletion:^(NSTimeInterval timeInterval, NSError *error) {
        self.totalDisplayOnTime = timeInterval;
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [self.logAnalyser processBatteryChargeFrom:self.startDate toDate:self.endDate completion:^(NSArray *times, NSArray *batteryValues, NSError *error) {
        self.batteryDates = times;
        self.batterValues = batteryValues;
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [self.logAnalyser inferAudioOnTimeFrom:self.startDate toDate:self.endDate WithCompletion:^(NSTimeInterval timeInterval, NSError *error) {
        self.totalAudioTime = timeInterval;
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        self.readyToReport = YES;
    });
}


@end
