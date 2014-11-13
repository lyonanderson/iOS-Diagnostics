//
//  ELLSqlPowerLogAnalyser.h
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 06/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELLSqlPowerLogAnalyser : NSObject

- (instancetype)initWithLogfile:(NSString *)logfile;

- (void)processNotificationsFrom:(NSDate *)fromDate toDate:(NSDate *)toDate completion:(void(^)(NSArray *notifications, NSError *error))completion;
- (void)processBatteryChargeFrom:(NSDate *)fromDate toDate:(NSDate *)toDate completion:(void(^)(NSArray *times, NSArray *batteryValues, NSError *error))completion;
- (void)processLocationUsesFrom:(NSDate *)fromDate toDate:(NSDate *)toDate completion:(void(^)(NSArray *locationUses, NSError *error))completion;
- (void)processProcessTimeBreakdownFrom:(NSDate *)fromDate toDate:(NSDate *)toDate completion:(void(^)(NSArray *processTimeBreakdown, NSError *error))completion;
- (void)processNotificationsFrom:(NSDate *)fromDate toDate:(NSDate *)toDate topic:(NSString *)topic completion:(void(^)(NSArray *notifications, NSError *error))completion;
- (void)processTotalEnergyFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate completion:(void(^)(NSArray *totalEnergyPerProcess, NSError *error))completion;
- (void)processEnergyBreakdownFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate processName:(NSString *)processName completion:(void(^)(NSArray *breakdownForProcess, NSError *error))completion;
- (void)processLocationUsesFrom:(NSDate *)fromDate toDate:(NSDate *)toDate forBundle:(NSString *)bundle completion:(void(^)(NSArray *locationUses, NSError *error))completion;
- (void)processSignalBarsFrom:(NSDate *)fromDate toDate:(NSDate *)toDate completion:(void(^)(NSArray *signalBreakdown, NSError *error))completion;
- (void)inferOnTimeFrom:(NSDate *)fromDate toDate:(NSDate *)toDate completion:(void(^)(NSTimeInterval timeInterval, NSError *error))completion;
- (void)inferDisplayOnTimeFrom:(NSDate *)fromDate toDate:(NSDate *)toDate WithCompletion:(void(^)(NSTimeInterval timeInterval, NSError *error))completion;
- (void)inferLoggingPeriodWithCompletion:(void(^)(NSDate *startDate, NSDate *endDate, NSError *error))completion;

@end
