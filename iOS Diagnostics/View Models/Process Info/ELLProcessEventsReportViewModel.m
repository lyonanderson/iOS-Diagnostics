//
//  ELLProcessEventsReportViewModel.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 14/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLProcessEventsReportViewModel.h"
#import "ELLProcessEventsReportModel.h"
#import "ELLProcessEvent.h"

@interface ELLProcessEventsReportViewModel ()
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSDateComponentsFormatter *dateComponentsFormatter;
@end

@implementation ELLProcessEventsReportViewModel


- (instancetype)initWithModel:(ELLReportSectionModel *)model reportTitle:(NSString *)reportTitle {
    if (self = [super initWithModel:model reportTitle:reportTitle]) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [_dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
        
        _dateComponentsFormatter = [[NSDateComponentsFormatter alloc] init];
        _dateComponentsFormatter.zeroFormattingBehavior = NSDateComponentsFormatterZeroFormattingBehaviorDropAll;
        _dateComponentsFormatter.unitsStyle = NSDateComponentsFormatterUnitsStyleAbbreviated;
        _dateComponentsFormatter.allowedUnits = (kCFCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond);
    }
    return self;
}


-(NSString *)titleAtIndexPath:(NSIndexPath *)indexPath {
    ELLProcessEvent *processEvent = [self processEventForIndexPath:indexPath];
    return  [_dateFormatter stringFromDate:processEvent.timestamp];
    
}

-(NSString *)detailAtIndexPath:(NSIndexPath *)indexPath {
    ELLProcessEvent *processEvent = [self processEventForIndexPath:indexPath];
    return processEvent.eventType;
}

- (ELLProcessEvent *)processEventForIndexPath:(NSIndexPath *)indexPath {
    ELLProcessEventsReportModel *processEventsModel = (ELLProcessEventsReportModel *)self.model;
    return processEventsModel.results[indexPath.row];
}

@end
