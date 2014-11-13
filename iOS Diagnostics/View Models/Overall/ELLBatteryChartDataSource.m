//
//  ELLBatteryChartDataSource.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 12/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLBatteryChartDataSource.h"


@interface ELLBatteryChartDataSource ()
@property (nonatomic, readwrite, strong) NSArray *batteryDates;
@property (nonatomic, readwrite, strong) NSArray *batteryValues;
@end

@implementation ELLBatteryChartDataSource


- (instancetype)initWithBatteryDates:(NSArray *)batteryDates batteryValues:(NSArray *)batteryValues {
    self = [super init];
    if (self) {
        _batteryDates = batteryDates;
        _batteryValues = batteryValues;
    }
    return self;
}

- (NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView {
    return 1;
}

- (NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex {
    return self.batteryDates.count;
}

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex {
    return [self.batteryValues[horizontalIndex] integerValue];
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForLineAtLineIndex:(NSUInteger)lineIndex {
    return [UIColor redColor];
}


- (CGFloat)lineChartView:(JBLineChartView *)lineChartView widthForLineAtLineIndex:(NSUInteger)lineIndex {
    return 2.0f;
}

- (JBLineChartViewLineStyle)lineChartView:(JBLineChartView *)lineChartView lineStyleForLineAtLineIndex:(NSUInteger)lineIndex {
    return JBLineChartViewLineStyleSolid;
}

- (BOOL)lineChartView:(JBLineChartView *)lineChartView smoothLineAtLineIndex:(NSUInteger)lineIndex {
    return YES;
}

@end
