//
//  MasterViewController.h
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 07/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ELLReportSectionViewController;
@class ELLPowerLogReportViewModel;

@interface ELLMasterViewController : UIViewController

@property (strong, nonatomic) ELLReportSectionViewController *detailViewController;
@property (strong, nonatomic) ELLPowerLogReportViewModel *viewModel;

@end

