//
//  ELLOverallReportModel.h
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 12/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLReportSectionModel.h"

@interface ELLOverallReportModel : ELLReportSectionModel

@property (nonatomic, readonly, assign) NSTimeInterval totalOnTime;
@property (nonatomic, readonly, assign) NSTimeInterval totalDisplayOnTime;
@property (nonatomic, readonly, strong) NSArray *batteryDates;
@property (nonatomic, readonly, strong) NSArray *batterValues;

@end
