//
//  ELLProcessTimeBreakdownModel.h
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 09/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLReportSectionModel.h"

@interface ELLProcessTimeBreakdownModel : ELLReportSectionModel

@property (nonatomic, readonly, strong) NSArray *processTimes;

@end
