//
//  MasterViewController.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 07/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLMasterViewController.h"
#import "ELLReportSectionViewController.h"
#import "ELLConfigViewController.h"
#import "ELLPowerLogReportViewModel.h"
#import <KVOController/FBKVOController.h>


@interface ELLMasterViewController ()<ELLConfigViewControllerDelegate>
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIView *loadingView;
@property (nonatomic, strong) IBOutlet UIView *errorView;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *refreshButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *shareButton;
@property (nonatomic, strong) NSIndexPath *lastSelectedIndexPath;

@property (nonatomic, strong) FBKVOController *KVOController;
@end

@implementation ELLMasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailViewController = (ELLReportSectionViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    [self viewModelStateChanged];
}

#pragma mark - Reload

- (IBAction)reload:(id)sender {
    [self.viewModel reload];
}

- (IBAction)shareLogfile:(id)sender {
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:@[[NSURL fileURLWithPath:self.viewModel.compressedLogFile]]
                                                                             applicationActivities:nil];
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        ELLReportSectionViewController *reportSectionViewController = navigationController.viewControllers[0];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ELLReportSectionViewModel *viewModel = [self.viewModel reportViewModelViewForIndexPath:indexPath];
        reportSectionViewController.viewModel = viewModel;
        
    } else if ([[segue identifier] isEqualToString:@"showConfig"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        ELLConfigViewController *playerDetailsViewController = navigationController.viewControllers[0];
        playerDetailsViewController.delegate = self;
        playerDetailsViewController.startDateTime = self.viewModel.constrainedStartDate;
        playerDetailsViewController.endDateTime = self.viewModel.constrainedEndDate;
    }
}


#pragma mark ELLConfigViewControllerDelegate

- (void)configViewControllerDidFinish:(ELLConfigViewController *)configViewController
                    withStartDateTime:(NSDate *)startDateTime
                          endDateTime:(NSDate *)endDateTime {
    
    self.viewModel.constrainedStartDate = startDateTime;
    self.viewModel.constrainedEndDate = endDateTime;
    if (self.lastSelectedIndexPath) {
        if (self.splitViewController.viewControllers.count > 1) {
            UINavigationController *navController = self.splitViewController.viewControllers[1];
            ELLReportSectionViewController *currentDetailController = (ELLReportSectionViewController *) navController.topViewController;
            currentDetailController.viewModel = [self.viewModel reportViewModelViewForIndexPath:self.lastSelectedIndexPath];
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)configViewControllerDidCancel:(ELLConfigViewController *)configViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfItemsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = [self.viewModel titleAtIndexPath:indexPath];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [self.viewModel titleForFooterInSection:section];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.lastSelectedIndexPath = indexPath;
    if (self.splitViewController.viewControllers.count == 1) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}


#pragma mark

- (void)viewModelStateChanged {
    if (self.viewModel.readyToReport) {
        self.tableView.hidden = NO;
        self.loadingView.hidden = YES;
        self.errorView.hidden = YES;
        self.navigationItem.leftBarButtonItem.enabled = YES;
        self.refreshButton.enabled = YES;
        self.shareButton.enabled = YES;
        [self.tableView reloadData];
    } else {
        self.tableView.hidden = YES;
        self.navigationItem.leftBarButtonItem.enabled = NO;
        self.refreshButton.enabled = NO;
        self.shareButton.enabled = NO;
        if (self.viewModel.loadError) {
            self.errorView.hidden =  NO;
            self.loadingView.hidden = YES;
            self.refreshButton.enabled = YES;
            self.shareButton.enabled = YES;
        } else {
            self.errorView.hidden = YES;
            self.loadingView.hidden = NO;
        }
        
    }
}

#pragma mark Setup View Model

- (void)setViewModel:(ELLPowerLogReportViewModel *)viewModel {
    if (_viewModel != viewModel) {
        _viewModel = viewModel;
        
        FBKVOController *KVOController = [FBKVOController controllerWithObserver:self];
        self.KVOController = KVOController;
        
        [self.KVOController observe:self.viewModel keyPath:@"readyToReport"
                            options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew
                              block:^(ELLMasterViewController *viewController, ELLPowerLogReportViewModel *viewModel, NSDictionary *change) {
                                  [viewController viewModelStateChanged];
                              }];

        
    }
}


@end
