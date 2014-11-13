//
//  ELLBatteryChartDataSource.h
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 12/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JBChartView/JBLineChartView.h>

@interface ELLBatteryChartDataSource : NSObject<JBLineChartViewDataSource, JBLineChartViewDelegate>

- (instancetype)initWithBatteryDates:(NSArray *)batteryDates batteryValues:(NSArray *)batteryValues;

@end
