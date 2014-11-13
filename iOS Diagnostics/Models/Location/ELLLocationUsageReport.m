//
//  ELLLocationUsageReport.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 11/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLLocationUsageReport.h"
#import "ELLReportSectionModel+Internal.h"
#import "ELLSqlPowerLogAnalyser.h"

@interface ELLLocationUsageReport ()
@property (nonatomic, readwrite, strong) NSArray *locationUsesForBundle;
@property (nonatomic, readwrite, strong) NSString *bundle;
@end

@implementation ELLLocationUsageReport

- (instancetype)initWithLogAnalyser:(ELLSqlPowerLogAnalyser *)logAnalyser startDate:(NSDate *)startDate endDate:(NSDate *)endDate bundle:(NSString *)bundle {
    if (self = [super initWithLogAnalyser:logAnalyser startDate:startDate endDate:endDate]) {
        _bundle = [bundle copy];
    }
    return self;
}

- (void)load {
    [self.logAnalyser processLocationUsesFrom:self.startDate toDate:self.endDate forBundle:self.bundle completion:^(NSArray *locationUses, NSError *error) {
        self.locationUsesForBundle = locationUses;
        self.readyToReport = YES;
    }];
}

@end
