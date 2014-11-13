//
//  DetailViewController.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 07/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#import "ELLReportSectionViewController.h"
#import <KVOController/FBKVOController.h>


@interface ELLReportSectionViewController ()
@property (nonatomic, strong) FBKVOController *KVOController;
@property (nonatomic, readwrite, strong) IBOutlet UITableView *tableView;
@property (nonatomic, readwrite, strong) IBOutlet UIView *noReportView;
@property (nonatomic, readwrite, strong) IBOutlet UIView *loadingView;

@property (nonatomic, strong) JBLineChartView *headerChart;
@end

@implementation ELLReportSectionViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self viewModelStateChanged];
    [self.viewModel load];
}

#pragma mark UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfItemsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    cell.accessoryType = [self.viewModel hasDetailForIndexPath:indexPath] ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    UILabel *titleLabel = (UILabel *) [cell viewWithTag:100];
    titleLabel.text = [self.viewModel titleAtIndexPath:indexPath];
    
    UILabel *detailLabel = (UILabel *) [cell viewWithTag:101];
    detailLabel.text = [self.viewModel detailAtIndexPath:indexPath];

}


- (void)viewModelStateChanged {
    if (self.viewModel) {
        if (self.viewModel.readyToReport) {
            self.tableView.hidden = NO;
            self.loadingView.hidden = YES;
            [self.tableView reloadData];
        } else {
            self.loadingView.hidden = NO;
            self.tableView.hidden = YES;
        }
        self.noReportView.hidden = YES;
    } else {
        self.noReportView.hidden = NO;
        self.loadingView.hidden = YES;
    }
}

#pragma mark Chart Setup

- (void)setupHeaderChart {
    self.headerChart = [[JBLineChartView alloc] init];
    self.headerChart.dataSource = self.viewModel.chartDataSource;
    self.headerChart.delegate = self.viewModel.chartDataSource;
    self.headerChart.maximumValue = 110.0f;
    self.headerChart.minimumValue = 0.0f;
    self.headerChart.backgroundColor =  RGBCOLOR(240.0f, 240.0f, 240.0f);
    self.headerChart.frame = CGRectMake(0.0f, 0.0f,
                                        CGRectGetWidth(self.tableView.frame),
                                        floorf(9./16. *  CGRectGetWidth(self.tableView.frame)));
    self.tableView.tableHeaderView = self.headerChart;

    [self.headerChart reloadData];
    
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        ELLReportSectionViewController *reportSectionViewController = segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ELLReportSectionViewModel *viewModel = [self.viewModel viewModelForDetailAtIndexPath:indexPath];
        reportSectionViewController.viewModel = viewModel;
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender  {
    if ([identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        return [self.viewModel hasDetailForIndexPath:indexPath];
    }
    return NO;
}


#pragma mark Setup View Model

- (void)setViewModel:(ELLReportSectionViewModel *)viewModel {
    if (_viewModel != viewModel) {
        _viewModel = viewModel;
        
        self.title = viewModel.reportTitle;
        
        FBKVOController *KVOController = [FBKVOController controllerWithObserver:self];
        self.KVOController = KVOController;
        
        [self.KVOController observe:self.viewModel keyPath:@"readyToReport"
                            options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew
                              block:^(ELLReportSectionViewController *viewController, ELLReportSectionViewModel *sectionViewModel, NSDictionary *change) {
                                  [viewController viewModelStateChanged];
                              }];
        
        [self.KVOController observe:self.viewModel keyPath:@"chartDataSource"
                            options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew
                              block:^(ELLReportSectionViewController *viewController, ELLReportSectionViewModel *sectionViewModel, NSDictionary *change) {
                                  if (viewModel.chartDataSource){
                                      [self setupHeaderChart];
                                  }
                              }];
        
        
    }
}

@end
