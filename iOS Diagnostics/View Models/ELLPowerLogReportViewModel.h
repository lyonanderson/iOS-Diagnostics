//
//  ELLPowerLogReportViewModel.h
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 08/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ELLPowerReportModel;
@class ELLReportSectionViewModel;

typedef NS_ENUM(NSUInteger, ELLPowerReportSection) {
    ELLPowerReportSectionBattery = 0,
    ELLPowerReportSectionNotifications,
    ELLPowerReportSectionCoreLocation,
    ELLPowerReportProcessTime,
    ELLPowerReportEnergyPerProcess,
    ELLPowerReportSignal,
    ELLPowerReportProcessInfo
};

@interface ELLPowerLogReportViewModel : NSObject

- (instancetype)initWithPowerLogModel:(ELLPowerReportModel *)reportModel;

@property (nonatomic, readonly, assign) BOOL readyToReport;
@property (nonatomic, readonly, strong) NSError *loadError;

@property (nonatomic, readonly, copy) NSString *compressedLogFile;

@property (nonatomic, readonly, copy) NSDate *startDate;
@property (nonatomic, readonly, copy) NSDate *endDate;
@property (nonatomic, readwrite, copy) NSDate *constrainedStartDate;
@property (nonatomic, readwrite, copy) NSDate *constrainedEndDate;

-(NSInteger)numberOfSections;
-(NSInteger)numberOfItemsInSection:(NSInteger)section;
-(NSString *)titleForFooterInSection:(NSInteger)section;
-(NSString *)titleForSection:(NSInteger)section;
-(NSString *)titleAtIndexPath:(NSIndexPath *)indexPath;

- (void)reload;

- (ELLReportSectionViewModel *)reportViewModelViewForIndexPath:(NSIndexPath *)indexPath;

@end
