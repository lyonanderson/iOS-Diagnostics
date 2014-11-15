//
//  ELLLocationReportViewModel.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 08/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLLocationReportViewModel.h"
#import "ELLLocationReportModel.h"
#import "ELLLocationCount.h"
#import "ELLLocationUsageReport.h"
#import "ELLLocationUsageReportViewModel.h"

@implementation ELLLocationReportViewModel


-(NSString *)titleAtIndexPath:(NSIndexPath *)indexPath {
    ELLLocationCount *locationCount = [self locationCountForIndexPath:indexPath];
    return [NSString stringWithFormat:@"%@\n[%@]", locationCount.client, locationCount.type];
}

-(NSString *)detailAtIndexPath:(NSIndexPath *)indexPath {
    return [NSString stringWithFormat:@"%ld", (long)[self locationCountForIndexPath:indexPath].count];
}

- (ELLReportSectionViewModel *)viewModelForDetailAtIndexPath:(NSIndexPath *)indexPath {
    ELLLocationCount *locationCount = [self locationCountForIndexPath:indexPath];
    ELLLocationUsageReport *model = [[ELLLocationUsageReport alloc] initWithLogAnalyser:self.model.logAnalyser
                                                                                    startDate:self.model.startDate
                                                                                      endDate:self.model.endDate
                                                                                       bundle:locationCount.client];
    
    ELLLocationUsageReportViewModel *viewModel = [[ELLLocationUsageReportViewModel alloc] initWithModel:model
                                                                                        reportTitle:locationCount.client];
    
    return viewModel;
}

- (BOOL)hasDetailForIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)canFilterResults {
    return YES;
}


#pragma mark Util

- (ELLLocationCount *)locationCountForIndexPath:(NSIndexPath *)indexPath {
    return self.results[indexPath.row];
}

@end
