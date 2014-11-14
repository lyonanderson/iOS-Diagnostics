//
//  ELLProcessEvent.h
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 14/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLReportSectionViewModel.h"

@interface ELLProcessEvent : ELLReportSectionViewModel

@property (nonatomic, readonly, copy) NSDate *timestamp;
@property (nonatomic, readonly, copy) NSString *eventType;
@property (nonatomic, readonly, assign) double length;


+ (instancetype)processEventWithTimestamp:(NSDate *)date type:(NSString *)eventType length:(double)length;

@end
