//
//  ELLReportSectionViewModel+Internal.h
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 12/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import <JBChartView/JBLineChartView.h>

@interface ELLReportSectionViewModel ()
- (void)setChartDataSource:(id<JBChartViewDataSource, JBLineChartViewDelegate>)dataSource;
@end