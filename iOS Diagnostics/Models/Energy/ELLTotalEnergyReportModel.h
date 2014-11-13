//
//  ELLTotalEnergyReportModel.h
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 10/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLReportSectionModel.h"

@interface ELLTotalEnergyReportModel : ELLReportSectionModel

@property (nonatomic, readonly, strong) NSArray *totalEnergyPerProcess;

@end
