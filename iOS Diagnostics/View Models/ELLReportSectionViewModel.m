//
//  ELLReportSectionViewModel.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 08/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLReportSectionViewModel.h"
#import "ELLReportSectionModel.h"

#import <KVOController/FBKVOController.h>

@interface ELLReportSectionViewModel ()
@property (nonatomic, readwrite, strong) ELLReportSectionModel *model;
@property (nonatomic, readwrite, assign) BOOL readyToReport;
@property (nonatomic, readwrite, assign) BOOL isFilteringResults;
@property (nonatomic, readwrite, copy) NSString *reportTitle;
@property (nonatomic, readwrite, strong) id<JBLineChartViewDataSource, JBLineChartViewDelegate> chartDataSource;

@property (nonatomic, strong) FBKVOController *KVOController;
@end

@implementation ELLReportSectionViewModel

- (instancetype)initWithModel:(ELLReportSectionModel *)model reportTitle:(NSString *)reportTitle {
    self = [super init];
    if (self) {
        _model = model;
        _reportTitle = [reportTitle copy];
        [self setupKVO];
    }
    return self;
}

- (void)load {
    [self.model load];
}

#pragma mark Setup KVO

- (void)setupKVO {
    FBKVOController *KVOController = [FBKVOController controllerWithObserver:self];
    self.KVOController = KVOController;
    
    [self.KVOController observe:self.model keyPath:@"readyToReport"
                        options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew
                          block:^(ELLReportSectionViewModel *viewModel, ELLReportSectionModel *model, NSDictionary *change) {
                              self.readyToReport = model.readyToReport;
                              [self generateChartDataSource];
                          }];
}

-(void)generateChartDataSource {
    
}

-(NSInteger)numberOfItemsInSection:(NSInteger)section {
    return 0;
}

-(NSString *)titleAtIndexPath:(NSIndexPath *)indexPath {
    return @"";
}

-(NSString *)detailAtIndexPath:(NSIndexPath *)indexPath {
    return @"";
}

-(BOOL)hasDetailForIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (ELLReportSectionViewModel *)viewModelForDetailAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (BOOL)canFilterResults {
    return NO;
}

- (void)filterResults:(NSString *)filterTerm {
    if (filterTerm.length > 0) {
        self.isFilteringResults = YES;
        [self.model filterResults:filterTerm];
    } else {
        self.isFilteringResults = NO;
        [self cancelFilter];
    }
   
}

- (void)cancelFilter {
    self.isFilteringResults = NO;
    self.readyToReport = YES;
}

@end
