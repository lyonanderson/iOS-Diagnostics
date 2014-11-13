//
//  ELLLocationReportModel.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 08/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLLocationReportModel.h"
#import "ELLReportSectionModel+Internal.h"
#import "ELLSqlPowerLogAnalyser.h"

@interface ELLLocationReportModel ()
@property (nonatomic, readwrite, strong) NSArray *locationClientUses;
@end

@implementation ELLLocationReportModel

- (void)load {
    [self.logAnalyser processLocationUsesFrom:self.startDate toDate:self.endDate completion:^(NSArray *locationUses, NSError *error) {
        if (!error) {
            self.locationClientUses = locationUses;
            self.readyToReport = YES;
        }
    }];
}

@end
