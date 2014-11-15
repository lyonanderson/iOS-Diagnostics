//
//  ELLProcessNamesReportModel.h
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 14/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLReportSectionModel.h"

@interface ELLProcessNamesReportModel : ELLReportSectionModel

@property (nonatomic, readonly, strong) NSArray *processNames;
@property (nonatomic, readonly, strong) NSArray *filteredProcessNames;

@end
