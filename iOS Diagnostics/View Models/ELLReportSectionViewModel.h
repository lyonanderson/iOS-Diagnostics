//
//  ELLReportSectionViewModel.h
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 08/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JBChartView/JBLineChartView.h>

@class ELLReportSectionModel;

@interface ELLReportSectionViewModel : NSObject

@property (nonatomic, readonly, strong) ELLReportSectionModel *model;
@property (nonatomic, readonly, assign) BOOL readyToReport;
@property (nonatomic, readonly, assign) BOOL isFilteringResults;
@property (nonatomic, readonly, strong) NSArray *results;
@property (nonatomic, readonly, copy) NSString *reportTitle;
@property (nonatomic, readonly, strong) id<JBLineChartViewDataSource, JBLineChartViewDelegate> chartDataSource;

- (instancetype)initWithModel:(ELLReportSectionModel *)model reportTitle:(NSString *)reportTitle;
- (void)load;

- (void)generateChartDataSource;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;
- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)detailAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)hasDetailForIndexPath:(NSIndexPath *)indexPath;
- (ELLReportSectionViewModel *)viewModelForDetailAtIndexPath:(NSIndexPath *)indexPath;

- (BOOL)canFilterResults;
- (void)filterResults:(NSString *)filterTerm;
- (void)cancelFilter;

@end
