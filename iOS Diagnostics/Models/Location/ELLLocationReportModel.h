//
//  ELLLocationReportModel.h
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 08/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELLReportSectionModel.h"

@interface ELLLocationReportModel : ELLReportSectionModel

@property (nonatomic, readonly, strong) NSArray *locationClientUses;

@end
