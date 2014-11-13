//
//  ELLSqlPowerLogAnalyser.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 06/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ELLSqlPowerLogAnalyser.h"
#import "ELLNotificationCount.h"
#import "ELLLocationCount.h"
#import "ELLProcessTime.h"
#import "ELLNotificationInfo.h"
#import "ELLTotalEnergyForProcess.h"
#import "ELLEnergyBreakdown.h"
#import "ELLLocationUsage.h"
#import <FMDB/FMDatabase.h>



@interface ELLSqlPowerLogAnalyser ()
@property (nonatomic, strong) FMDatabase *logfileDatabase;
@property (nonatomic, strong) dispatch_queue_t loadingQueue;
@end

@implementation ELLSqlPowerLogAnalyser

- (instancetype)initWithLogfile:(NSString *)logfile {
    self = [super init];
    if (self) {
        _loadingQueue = dispatch_queue_create("com.electriclabs.sqlQueue", 0);
        _logfileDatabase = [FMDatabase databaseWithPath:logfile];
        [_logfileDatabase open];
    }
    return self;
}

- (void)dealloc {
    [_logfileDatabase close];
}

- (void)processNotificationsFrom:(NSDate *)fromDate toDate:(NSDate *)toDate completion:(void(^)(NSArray *notifications, NSError *error))completion {
    dispatch_async(self.loadingQueue, ^{
        FMResultSet *results = [self.logfileDatabase executeQueryWithFormat:@"SELECT Topic, COUNT(Topic) AS Count FROM PLXPCAgent_EventPoint_Apsd WHERE timestamp > %f AND timestamp < %f GROUP BY Topic ORDER BY Count DESC", fromDate.timeIntervalSince1970, toDate.timeIntervalSince1970];
        
        NSMutableArray *notificationCounts = [NSMutableArray array];
        
        while ([results next]) {
            ELLNotificationCount *notificationCount = [ELLNotificationCount notificationCountWithTopic:[results stringForColumn:@"Topic"] count:[results intForColumn:@"Count"]];
            [notificationCounts addObject:notificationCount];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
             completion(notificationCounts, nil);
        });
    });
}

- (void)processNotificationsFrom:(NSDate *)fromDate toDate:(NSDate *)toDate topic:(NSString *)topic completion:(void(^)(NSArray *notifications, NSError *error))completion {
    dispatch_async(self.loadingQueue, ^{
        FMResultSet *results = [self.logfileDatabase executeQueryWithFormat:@"SELECT timestamp, ConnectionType FROM PLXPCAgent_EventPoint_Apsd WHERE timestamp > %f AND timestamp < %f AND topic= %@ ORDER BY timestamp ASC", fromDate.timeIntervalSince1970, toDate.timeIntervalSince1970, topic];
        
        NSMutableArray *notificationTopicInfo = [NSMutableArray array];
        
        while ([results next]) {
            ELLNotificationInfo *notificationInfo = [ELLNotificationInfo infoWithConnectionType:[results stringForColumn:@"ConnectionType"]
                                                                                      timestamp:[NSDate dateWithTimeIntervalSince1970:[results longLongIntForColumn:@"timestamp"]]];
           [notificationTopicInfo addObject:notificationInfo];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(notificationTopicInfo, nil);
        });
    });
}

- (void)processTotalEnergyFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate completion:(void(^)(NSArray *totalEnergyPerProcess, NSError *error))completion {
    dispatch_async(self.loadingQueue, ^{
        FMResultSet *results = [self.logfileDatabase executeQueryWithFormat:@"SELECT BLMAppName As Bundle, "\
                                "SUM(BLMEnergy) AS BLMEnergy "\
                                "FROM PLBLMAccountingService_Aggregate_BLMAppEnergyBreakdown "\
                                "WHERE timestamp > %f AND timestamp < %f AND "\
                                "timeInterval == 3600 "\
                                "GROUP BY Bundle " \
                                "ORDER BY BLMEnergy DESC",
                                fromDate.timeIntervalSince1970, toDate.timeIntervalSince1970];
        
        NSMutableArray *totalEnergyPerProcess = [NSMutableArray array];
        
        while ([results next]) {
            ELLTotalEnergyForProcess *totalEnergyFprProcess = [ELLTotalEnergyForProcess totalEnergyWithProcessName:[results stringForColumn:@"Bundle"]
                                                                                                       totalEnergy:[results doubleForColumn:@"BLMEnergy"]];
            [totalEnergyPerProcess addObject:totalEnergyFprProcess];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(totalEnergyPerProcess, nil);
        });

    });
}


- (void)processEnergyBreakdownFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate processName:(NSString *)processName completion:(void(^)(NSArray *breakdownForProcess, NSError *error))completion {
    dispatch_async(self.loadingQueue, ^{
        FMResultSet *results = [self.logfileDatabase executeQueryWithFormat:@"SELECT BLMAppName As Bundle, "\
                                "SUM(Airdrop) AS Airdrop, "\
                                "SUM(Airplay) AS Airplay, "\
                                "SUM(AirplayMirroring) AS AirplayMirroring, "\
                                "SUM(BBCondition) AS BBCondition, "\
                                "SUM(BLMEnergy) AS BLMEnergy, "\
                                "SUM(BLMEnergyAccessory) AS BLMEnergyAccessory, "\
                                "SUM(BLMEnergyAssertion) AS BLMEnergyAssertion, "\
                                "SUM(BLMEnergyAudio) AS BLMEnergyAudio, "\
                                "SUM(BLMEnergyBB) AS BLMEnergyBB, "\
                                "SUM(BLMEnergyBluetooth) AS BLMEnergyBluetooth, "\
                                "SUM(BLMEnergyCPU) AS BLMEnergyCPU, "\
                                "SUM(BLMEnergyDisplay) AS BLMEnergyDisplay, "\
                                "SUM(BLMEnergyGPS) AS BLMEnergyGPS, "\
                                "SUM(BLMEnergyGPU) AS BLMEnergyGPU, "\
                                "SUM(BLMEnergyPA_accessories) AS BLMEnergyPA_accessories, "\
                                "SUM(BLMEnergyPA_apsd) AS BLMEnergyPA_apsd, "\
                                "SUM(BLMEnergyPA_assetsd) AS BLMEnergyPA_assetsd, "\
                                "SUM(BLMEnergyPA_backboardd) AS BLMEnergyPA_backboardd, "\
                                "SUM(BLMEnergyPA_cloudd) AS BLMEnergyPA_cloudd, "\
                                "SUM(BLMEnergyPA_commcenter) AS BLMEnergyPA_commcenter, "\
                                "SUM(BLMEnergyPA_discoverydBB) AS BLMEnergyPA_discoverydBB, "\
                                "SUM(BLMEnergyPA_discoverydWifi) AS BLMEnergyPA_discoverydWifi, "\
                                "SUM(BLMEnergyPA_kernel_task) AS BLMEnergyPA_kernel_task, "\
                                "SUM(BLMEnergyPA_locationd) AS BLMEnergyPA_locationd, "\
                                "SUM(BLMEnergyPA_mediaserverd) AS BLMEnergyPA_mediaserverd, "\
                                "SUM(BLMEnergyPA_notification_display) AS BLMEnergyPA_notification_display, "\
                                "SUM(BLMEnergyPA_nsurlsessiond) AS BLMEnergyPA_nsurlsessiond, "\
                                "SUM(BLMEnergyPA_syncdefaultd) AS BLMEnergyPA_syncdefaultd, "\
                                "SUM(BLMEnergySOC) AS BLMEnergySOC, "\
                                "SUM(BLMEnergyTorch) AS BLMEnergyTorch, "\
                                "SUM(BLMEnergyWiFi) AS BLMEnergyWiFi, "\
                                "SUM(BLMEnergyWiFiLocationScan) AS BLMEnergyWiFiLocationScan, "\
                                "SUM(BLMEnergyWiFiPipelineScan) AS BLMEnergyWiFiPipelineScan, "\
                                "SUM(BLMEnergy_BackgroundCPU) AS BLMEnergy_BackgroundCPU, "\
                                "SUM(BLMEnergy_BackgroundLocation)  BLMEnergy_BackgroundLocation, "\
                                "SUM(background) AS  background "\
                                "FROM PLBLMAccountingService_Aggregate_BLMAppEnergyBreakdown "\
                                "WHERE Bundle = %@ AND " \
                                "timestamp > %f AND timestamp < %f AND "\
                                "timeInterval == 3600 "\
                                "GROUP BY Bundle " \
                                "ORDER BY BLMEnergy DESC",
                                processName, fromDate.timeIntervalSince1970, toDate.timeIntervalSince1970];
        
        NSMutableArray *breakdownForProcess = [NSMutableArray array];
        if ([results next]) {
            NSDictionary *row =[results resultDictionary];
            [row enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSNumber *val, BOOL *stop) {
                CGFloat energy = 0.0f;
                if ([val isKindOfClass:[NSNumber class]]) {
                    energy = val.floatValue;
                }
                ELLEnergyBreakdown *breakdown = [ELLEnergyBreakdown energyBreakdownWithKind:key energy:energy];
                [breakdownForProcess addObject:breakdown];
            }];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            completion(breakdownForProcess, nil);
        });
        
    });
}

- (void)processBatteryChargeFrom:(NSDate *)fromDate toDate:(NSDate *)toDate completion:(void(^)(NSArray *times, NSArray *batteryValues, NSError *error))completion {
      dispatch_async(self.loadingQueue, ^{
          FMResultSet *results = [self.logfileDatabase executeQueryWithFormat:@"SELECT timestamp, Level from PLBatteryAgent_EventBackward_Battery WHERE timestamp > %f AND timestamp < %f ORDER BY timestamp", fromDate.timeIntervalSince1970, toDate.timeIntervalSince1970];
          
          NSMutableArray *times = [NSMutableArray array];
          NSMutableArray *batteryValues = [NSMutableArray array];
          
          while ([results next]) {
              NSDate *time = [NSDate dateWithTimeIntervalSince1970:[results longLongIntForColumn:@"timestamp"]];
              NSInteger batteryValue= [results intForColumn:@"Level"];
              if (time) {
                  [times addObject:time];
                  [batteryValues addObject:@(batteryValue)];
              }
          }
          dispatch_async(dispatch_get_main_queue(), ^{
              completion(times, batteryValues, nil);
          });
      });
}

- (void)processLocationUsesFrom:(NSDate *)fromDate toDate:(NSDate *)toDate completion:(void(^)(NSArray *locationUses, NSError *error))completion {
     dispatch_async(self.loadingQueue, ^{
         FMResultSet *results = [self.logfileDatabase executeQueryWithFormat: @"SELECT Client, Type, COUNT(Client) AS Count FROM PLLocationAgent_EventForward_ClientStatus WHERE timestamp > %f AND timestamp < %f GROUP BY Client ORDER BY Count DESC", fromDate.timeIntervalSince1970, toDate.timeIntervalSince1970];
         
         NSMutableArray *locationUses = [NSMutableArray array];
         
         while ([results next]) {
             ELLLocationCount *locationCount = [ELLLocationCount locationCountWithClient:[results stringForColumn:@"Client"]
                                                                                    type:[results stringForColumn:@"Type"]
                                                                                   count:[results  intForColumn:@"Count"]];
             [locationUses addObject:locationCount];
         }
         dispatch_async(dispatch_get_main_queue(), ^{
             completion(locationUses, nil);

         });
    });
}

- (void)processLocationUsesFrom:(NSDate *)fromDate toDate:(NSDate *)toDate forBundle:(NSString *)bundle completion:(void(^)(NSArray *locationUses, NSError *error))completion {
    dispatch_async(self.loadingQueue, ^{
        FMResultSet *results = [self.logfileDatabase executeQueryWithFormat: @"SELECT timestamp, timestampEnd FROM PLLocationAgent_EventForward_ClientStatus WHERE Client = %@ AND timestamp > %f AND timestamp < %f ORDER BY timestamp ASC", bundle, fromDate.timeIntervalSince1970, toDate.timeIntervalSince1970];
        
        NSMutableArray *locationUserForBundle = [NSMutableArray array];
        
        while ([results next]) {
            NSDate *timestamp = [NSDate dateWithTimeIntervalSince1970:[results doubleForColumn:@"timestamp"]];
            NSDate *timestampEnd = [NSDate dateWithTimeIntervalSince1970:[results doubleForColumn:@"timestampEnd"]];
            
            ELLLocationUsage *locationUsage = [ELLLocationUsage locationUsageWithTimestamp:timestamp timestampEnd:timestampEnd];
            [locationUserForBundle addObject:locationUsage];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(locationUserForBundle, nil);
            
        });
    });
}



- (void)processProcessTimeBreakdownFrom:(NSDate *)fromDate toDate:(NSDate *)toDate completion:(void(^)(NSArray *processTimeBreakdown, NSError *error))completion {
      dispatch_async(self.loadingQueue, ^{
          FMResultSet *results = [self.logfileDatabase executeQueryWithFormat: @"SELECT processName, SUM(value) AS TotalTime "\
                                  "FROM PLProcessMonitorAgent_EventInterval_ProcessMonitorInterval_Dynamic, PLProcessMonitorAgent_EventInterval_ProcessMonitorInterval " \
                                  "WHERE PLProcessMonitorAgent_EventInterval_ProcessMonitorInterval.ID = PLProcessMonitorAgent_EventInterval_ProcessMonitorInterval_Dynamic.FK_ID AND " \
                                  "timestamp > %f AND timestamp < %f "
                                  "GROUP BY processname "\
                                  "ORDER BY TotalTime DESC", fromDate.timeIntervalSince1970, toDate.timeIntervalSince1970];
          
          NSMutableArray *processTimes = [NSMutableArray array];
          
          while ([results next]) {
              ELLProcessTime *processTime = [ELLProcessTime processTimeWithName:[results stringForColumn:@"processName"] processTime:[results  longForColumn:@"TotalTime"]];
              [processTimes addObject:processTime];
          }
          dispatch_async(dispatch_get_main_queue(), ^{
               completion(processTimes, nil);
          });
      });
}

- (void)processSignalBarsFrom:(NSDate *)fromDate toDate:(NSDate *)toDate completion:(void(^)(NSArray *signalBreakdown, NSError *error))completion {
    dispatch_async(self.loadingQueue, ^{
        FMResultSet *results = [self.logfileDatabase executeQueryWithFormat: @"SELECT signalBars, "\
                                "ROUND(CAST(COUNT(*) AS REAL)/total, 2) * 100 AS percent "\
                                "FROM PLBBAgent_EventPoint_TelephonyActivity "\
                                "CROSS JOIN "\
                                "( SELECT COUNT(*) AS total "\
                                " FROM PLBBAgent_EventPoint_TelephonyActivity "\
                                " WHERE airplaneMode='off' AND "\
                                " timestamp > %f AND timestamp < %f "\
                                " ) "\
                                "WHERE airplaneMode='off' AND "\
                                "timestamp > %f AND timestamp < %f "\
                                "GROUP BY signalBars ",
                                fromDate.timeIntervalSince1970, toDate.timeIntervalSince1970,
                                fromDate.timeIntervalSince1970, toDate.timeIntervalSince1970];
        
        NSMutableArray *breakdown = [@[@(0), @(0), @(0), @(0), @(0), @(0)] mutableCopy];

        while([results next]) {
            NSInteger signalBar = [results intForColumn:@"signalBars"];
            breakdown[signalBar] = @([results intForColumn:@"percent"]);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(breakdown, nil);
        });
    });
}
//

- (void)inferOnTimeFrom:(NSDate *)fromDate toDate:(NSDate *)toDate completion:(void(^)(NSTimeInterval timeInterval, NSError *error))completion {
    dispatch_async(self.loadingQueue, ^{
        FMResultSet *results = [self.logfileDatabase executeQueryWithFormat:@"SELECT  timestamp, state "\
                                "FROM PLSleepWakeAgent_EventForward_PowerState "\
                                "WHERE timestamp > %f AND timestamp < %f "\
                                "ORDER BY timestamp", fromDate.timeIntervalSince1970, toDate.timeIntervalSince1970];
        NSTimeInterval accumulator = 0;
        NSTimeInterval lastOn = 0;
        while ([results next]) {
            NSTimeInterval currentTime = [results doubleForColumn:@"timestamp"];
            NSInteger state = [results intForColumn:@"state"];
            
            if (state == 1) {
                if (lastOn != 0) {
                    accumulator += (currentTime - lastOn);
                    lastOn = 0;
                }
            } else if (state == 0 && lastOn == 0) {
                lastOn = currentTime;
            }
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(accumulator, nil);
        });
    });
}


- (void)inferDisplayOnTimeFrom:(NSDate *)fromDate toDate:(NSDate *)toDate WithCompletion:(void(^)(NSTimeInterval timeInterval, NSError *error))completion {
    dispatch_async(self.loadingQueue, ^{
        FMResultSet *results = [self.logfileDatabase executeQueryWithFormat:@"SELECT timestamp, Active "\
                                "FROM PLDisplayAgent_EventPoint_Display "\
                                "WHERE timestamp > %f AND timestamp < %f "\
                                "ORDER BY timestamp", fromDate.timeIntervalSince1970, toDate.timeIntervalSince1970];
        NSTimeInterval accumulator = 0;
        NSTimeInterval lastOn = 0;
        while ([results next]) {
            NSTimeInterval currentTime = [results doubleForColumn:@"timestamp"];
            NSInteger state = [results intForColumn:@"Active"];
            
            if (state == 0) {
                if (lastOn != 0) {
                    accumulator += (currentTime - lastOn);
                    lastOn = 0;
                }
            } else if (state == 1 && lastOn == 0) {
                lastOn = currentTime;
            }
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(accumulator, nil);
            
        });
    });
}

- (void)inferLoggingPeriodWithCompletion:(void(^)(NSDate *startDate, NSDate *endDate, NSError *error))completion {
    dispatch_async(self.loadingQueue, ^{
        FMResultSet *results = [self.logfileDatabase executeQuery:@"SELECT min(timestamp) as first, max(timestamp) as last FROM PLPowerAssertionAgent_EventInterval_Assertion"];
        NSDate *firstDate, *lastDate;
        if ([results next]) {
            firstDate = [NSDate dateWithTimeIntervalSince1970:[results longLongIntForColumn:@"first"]];
            lastDate = [NSDate dateWithTimeIntervalSince1970:[results longLongIntForColumn:@"last"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
             completion(firstDate, lastDate, nil);
            
        });
    });
}

@end
