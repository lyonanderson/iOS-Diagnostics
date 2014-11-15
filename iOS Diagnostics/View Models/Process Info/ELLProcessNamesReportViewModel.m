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

-(NSString *)titleAtIndexPath:(NSIndexPath *)indexPath {
    return self.results[indexPath.row];
}

-(NSString *)detailAtIndexPath:(NSIndexPath *)indexPath {
    return @"";
}

- (BOOL)hasDetailForIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (ELLReportSectionViewModel *)viewModelForDetailAtIndexPath:(NSIndexPath *)indexPath {
    NSString *processNameAtIndexPath = self.results[indexPath.row];
    
    ELLProcessEventsReportModel *model = [[ELLProcessEventsReportModel alloc] initWithLogAnalyser:self.model.logAnalyser
                                                                                        startDate:self.model.startDate
                                                                                          endDate:self.model.endDate
                                                                                      processName:processNameAtIndexPath];
    
    ELLProcessEventsReportViewModel *viewModel = [[ELLProcessEventsReportViewModel alloc] initWithModel:model
                                                                                            reportTitle:processNameAtIndexPath];
    
    return viewModel;
}

#pragma mark Filtering

- (BOOL)canFilterResults {
    return YES;
}




@end
