//
//  ELLProcessNamesReportViewModel.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 14/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLProcessNamesReportViewModel.h"
#import "ELLProcessNamesReportModel.h"
#import "ELLProcessEventsReportModel.h"
#import "ELLProcessEventsReportViewModel.h"


@implementation ELLProcessNamesReportViewModel

-(NSInteger)numberOfItemsInSection:(NSInteger)section {
    ELLProcessNamesReportModel *processNamesModel = (ELLProcessNamesReportModel *)self.model;
    return processNamesModel.processNames.count;
}

-(NSString *)titleAtIndexPath:(NSIndexPath *)indexPath {
    ELLProcessNamesReportModel *processNamesModel = (ELLProcessNamesReportModel *)self.model;
    return processNamesModel.processNames[indexPath.row];
   
}

-(NSString *)detailAtIndexPath:(NSIndexPath *)indexPath {
   return @"";
}

- (BOOL)hasDetailForIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (ELLReportSectionViewModel *)viewModelForDetailAtIndexPath:(NSIndexPath *)indexPath {
    ELLProcessNamesReportModel *processNamesModel = (ELLProcessNamesReportModel *)self.model;
    NSString *processNameAtIndexPath = processNamesModel.processNames[indexPath.row];
    
    ELLProcessEventsReportModel *model = [[ELLProcessEventsReportModel alloc] initWithLogAnalyser:self.model.logAnalyser
                                                                                            startDate:self.model.startDate
                                                                                              endDate:self.model.endDate
                                                                                          processName:processNameAtIndexPath];
    
    ELLProcessEventsReportViewModel *viewModel = [[ELLProcessEventsReportViewModel alloc] initWithModel:model
                                                                                                reportTitle:processNameAtIndexPath];
    
    return viewModel;
}

@end
