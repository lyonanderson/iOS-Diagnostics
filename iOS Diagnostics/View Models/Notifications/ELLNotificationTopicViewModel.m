//
//  ELLNotificationTopicViewModel.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 10/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELLNotificationTopicViewModel.h"
#import "ELLNotificationTopicModel.h"
#import "ELLNotificationInfo.h"

@interface ELLNotificationTopicViewModel ()
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation ELLNotificationTopicViewModel

- (instancetype)initWithModel:(ELLReportSectionModel *)model reportTitle:(NSString *)reportTitle {
    if (self = [super initWithModel:model reportTitle:reportTitle]) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [_dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    }
    return self;
}

-(NSInteger)numberOfItemsInSection:(NSInteger)section {
    ELLNotificationTopicModel *notificationModel = (ELLNotificationTopicModel *)self.model;
    return notificationModel.notificationTopicInfo.count;
}

-(NSString *)titleAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dateFormatter stringFromDate:[self notificationCountForIndexPath:indexPath].timestamp];
}

-(NSString *)detailAtIndexPath:(NSIndexPath *)indexPath {
    return [self notificationCountForIndexPath:indexPath].connectionType;
}


#pragma mark Util

- (ELLNotificationInfo *)notificationCountForIndexPath:(NSIndexPath *)indexPath {
    ELLNotificationTopicModel *notificationModel = (ELLNotificationTopicModel *)self.model;
    return notificationModel.notificationTopicInfo[indexPath.row];
}


@end
