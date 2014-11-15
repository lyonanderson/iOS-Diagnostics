//
//  ELLNotificationReportViewModel.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 08/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELLNotificationReportViewModel.h"
#import "ELLNotificationReportModel.h"
#import "ELLNotificationTopicModel.h"
#import "ELLNotificationTopicViewModel.h"
#import "ELLNotificationCount.h"

@implementation ELLNotificationReportViewModel

-(NSString *)titleAtIndexPath:(NSIndexPath *)indexPath {
    return [self notificationCountForIndexPath:indexPath].topic;
}

-(NSString *)detailAtIndexPath:(NSIndexPath *)indexPath {
    return [NSString stringWithFormat:@"%ld", (long)[self notificationCountForIndexPath:indexPath].count];
}

- (ELLReportSectionViewModel *)viewModelForDetailAtIndexPath:(NSIndexPath *)indexPath {
    ELLNotificationCount *notificationCount = [self notificationCountForIndexPath:indexPath];
    ELLNotificationTopicModel *model = [[ELLNotificationTopicModel alloc] initWithLogAnalyser:self.model.logAnalyser
                                                                                    startDate:self.model.startDate
                                                                                      endDate:self.model.endDate
                                                                                        topic:notificationCount.topic];
    
    ELLNotificationTopicViewModel *viewModel = [[ELLNotificationTopicViewModel alloc] initWithModel:model
                                                                                        reportTitle:notificationCount.topic];
    
    return viewModel;
}

- (BOOL)hasDetailForIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)canFilterResults {
    return YES;
}

#pragma mark Util

- (ELLNotificationCount *)notificationCountForIndexPath:(NSIndexPath *)indexPath {
    return self.results[indexPath.row];
}

@end
