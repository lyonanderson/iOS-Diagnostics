//
//  DetailViewController.h
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 07/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELLReportSectionViewModel.h"

@interface ELLReportSectionViewController : UIViewController

@property (nonatomic, readwrite, strong) ELLReportSectionViewModel *viewModel;


@end

