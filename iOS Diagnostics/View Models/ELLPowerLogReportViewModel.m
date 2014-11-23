//
//  ELLPowerLogReportViewModel.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 08/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLPowerLogReportViewModel.h"
#import "ELLPowerReportModel.h"
#import "ELLNotificationReportViewModel.h"
#import "ELLSqlPowerLogAnalyser.h"
#import "ELLNotificationReportModel.h"
#import "ELLLocationReportViewModel.h"
#import "ELLLocationReportModel.h"
#import "ELLProcessTimeBreakdownModel.h"
#import "ELLProcessTimeBreakdownViewModel.h"
#import "ELLTotalEnergyReportModel.h"
#import "ELLTotalEnergyReportViewModel.h"
#import "ELLSignalBreakdownModel.h"
#import "ELLSignalBreakdownViewModel.h"
#import "ELLOverallReportModel.h"
#import "ELLOverallReportViewModel.h"
#import "ELLProcessNamesReportModel.h"
#import "ELLProcessNamesReportViewModel.h"
#import "ELLApplicationsUsingAudioReportModel.h"
#import "ELLApplicationsUsingAudioReportViewModel.h"

#import <KVOController/FBKVOController.h>

@interface ELLPowerLogReportViewModel ()
@property (nonatomic, readwrite, assign) BOOL readyToReport;
@property (nonatomic, readwrite, strong) NSError *loadError;

@property (nonatomic, readwrite, copy) NSString *compressedLogFile;

@property (nonatomic, strong) ELLPowerReportModel *model;
@property (nonatomic, strong) FBKVOController *KVOController;

@property (nonatomic, readwrite, copy) NSDate *startDate;
@property (nonatomic, readwrite, copy) NSDate *endDate;


@property (nonatomic, readwrite, strong) NSDateFormatter *dateFormatter;

@property (nonatomic, strong) ELLSqlPowerLogAnalyser *logAnalyser;

@end

@implementation ELLPowerLogReportViewModel

- (instancetype)initWithPowerLogModel:(ELLPowerReportModel *)reportModel {
    self = [super init];
    if (self) {
        _model = reportModel;
        
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [_dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        
        [self setupKVO];
    }
    return self;
}

-(NSInteger)numberOfSections {
    return 1;
}

-(NSInteger)numberOfItemsInSection:(NSInteger)section {
    return 8;
}

-(NSString *)titleForSection:(NSInteger)section {
    return @"Reports";
}

-(NSString *)titleAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case ELLPowerReportSectionBattery: {
             return @"Overal Metrics";
        }
        case ELLPowerReportSectionNotifications: {
             return @"Notifications";
        }
        case ELLPowerReportSectionCoreLocation: {
            return @"Core Location";
        }
        case ELLPowerReportProcessTime: {
            return @"Process Time";
        }
        case ELLPowerReportEnergyPerProcess: {
            return @"Energy";
        }
        case ELLPowerReportSignal: {
            return @"Signal Bars";
        }
        case ELLPowerReportProcessInfo:
            return @"Process Info";
        case ELLPowerReportAudio:
            return @"Audio";
        default:
            return @"";
    }
}

-(NSString *)titleForFooterInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Log coverage from %@ to %@",
            [_dateFormatter stringFromDate:self.startDate],
            [_dateFormatter stringFromDate:self.endDate]];
}

- (void)reload {
    [self.model reload];
}

#pragma mark View Model Generation

- (ELLReportSectionViewModel *)reportViewModelViewForIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case ELLPowerReportSectionBattery: {
            ELLOverallReportModel *model = [[ELLOverallReportModel alloc] initWithLogAnalyser:self.logAnalyser
                                                                                    startDate:self.constrainedStartDate
                                                                                      endDate:self.constrainedEndDate];
            return [[ELLOverallReportViewModel alloc] initWithModel:model reportTitle:[self titleAtIndexPath:indexPath]];
         }
        case ELLPowerReportSectionNotifications: {
            ELLNotificationReportModel *model = [[ELLNotificationReportModel alloc] initWithLogAnalyser:self.logAnalyser
                                                                                              startDate:self.constrainedStartDate
                                                                                                endDate:self.constrainedEndDate];
            return [[ELLNotificationReportViewModel alloc] initWithModel:model
                                                             reportTitle:[self titleAtIndexPath:indexPath]];
        }
        case ELLPowerReportSectionCoreLocation: {
            ELLLocationReportModel *model = [[ELLLocationReportModel alloc] initWithLogAnalyser:self.logAnalyser
                                                                                      startDate:self.constrainedStartDate
                                                                                        endDate:self.constrainedEndDate];
            return [[ELLLocationReportViewModel alloc] initWithModel:model
                                                         reportTitle:[self titleAtIndexPath:indexPath]];
        }
        case ELLPowerReportProcessTime: {
            ELLProcessTimeBreakdownModel *model = [[ELLProcessTimeBreakdownModel alloc] initWithLogAnalyser:self.logAnalyser
                                                                                                  startDate:self.constrainedStartDate
                                                                                                    endDate:self.constrainedEndDate];
            return [[ELLProcessTimeBreakdownViewModel alloc] initWithModel:model
                                                               reportTitle:[self titleAtIndexPath:indexPath]];
        }
        case ELLPowerReportEnergyPerProcess: {
            ELLTotalEnergyReportModel *model = [[ELLTotalEnergyReportModel alloc] initWithLogAnalyser:self.logAnalyser
                                                                                            startDate:self.constrainedStartDate
                                                                                              endDate:self.constrainedEndDate];
            return [[ELLTotalEnergyReportViewModel alloc] initWithModel:model reportTitle:[self titleAtIndexPath:indexPath]];
        }
        case ELLPowerReportSignal: {
            ELLSignalBreakdownModel *model = [[ELLSignalBreakdownModel alloc] initWithLogAnalyser:self.logAnalyser
                                                                                        startDate:self.constrainedStartDate
                                                                                          endDate:self.constrainedEndDate];
            return [[ELLSignalBreakdownViewModel alloc] initWithModel:model reportTitle:[self titleAtIndexPath:indexPath]];
        }
        case ELLPowerReportProcessInfo: {
            
            ELLProcessNamesReportModel *model = [[ELLProcessNamesReportModel alloc] initWithLogAnalyser:self.logAnalyser
                                                                                              startDate:self.constrainedStartDate
                                                                                                endDate:self.constrainedEndDate];
            return [[ELLProcessNamesReportViewModel alloc] initWithModel:model reportTitle:[self titleAtIndexPath:indexPath]];
        }
        case ELLPowerReportAudio: {
            ELLApplicationsUsingAudioReportModel *model = [[ELLApplicationsUsingAudioReportModel alloc] initWithLogAnalyser:self.logAnalyser
                                                                                                                  startDate:self.constrainedStartDate
                                                                                                                    endDate:self.constrainedEndDate];
            return [[ELLApplicationsUsingAudioReportViewModel alloc] initWithModel:model reportTitle:[self titleAtIndexPath:indexPath]];
        }
        default:
            return nil;
    }
}

- (void)setupForReport:(NSUInteger)report {
    self.logAnalyser = [self.model logAnalyserForReport:report];
    [self.logAnalyser inferLoggingPeriodWithCompletion:^(NSDate *startDate, NSDate *endDate, NSError *error) {
        if (!error) {
            self.startDate = startDate;
            self.endDate = endDate;
            self.constrainedStartDate = startDate;
            self.constrainedEndDate = endDate;
            
            self.readyToReport = YES;
        }
    }];
}

- (void)updateState {
    if (self.model.readyToReport) {
        if (self.model.numberOfReports) {
            [self setupForReport:0]; // Do the first report for now
            self.compressedLogFile = self.model.compressedReportFiles[0];
        }
    } else {
        self.loadError = self.model.loadError;
        self.readyToReport = NO;
    }
   
}

#pragma mark Setup KVO

- (void)setupKVO {
    FBKVOController *KVOController = [FBKVOController controllerWithObserver:self];
    self.KVOController = KVOController;
    
    [self.KVOController observe:self.model keyPath:@"readyToReport"
                        options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew
                          block:^(ELLPowerLogReportViewModel *viewModel, ELLPowerReportModel *model, NSDictionary *change) {
                              [viewModel updateState];
    }];
}

@end
