//
//  ELLConfigViewController.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 07/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLConfigViewController.h"

static const NSInteger kDatePickerTag = 99;

static NSString *kDateCellID = @"dateCell";
static NSString *kDatePickerID = @"datePicker";
static NSString *kQuickLinkID = @"quickLinkCell";

static NSString *kTitleKey = @"titleKey";
static NSString *kDateKey = @"dateKey";

@interface ELLConfigViewController ()
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@property (nonatomic, strong) IBOutlet UIDatePicker *pickerView;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, assign) CGFloat pickerCellRowHeight;
@property (nonatomic, strong) NSIndexPath *datePickerIndexPath;

@property (nonatomic, strong) NSArray *tableContents;

@end

@implementation ELLConfigViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];


    NSMutableDictionary *itemOne = [@{ kTitleKey : @"Start Date",
                                       kDateKey : self.startDateTime ?: [NSDate date] } mutableCopy];
    NSMutableDictionary *itemTwo = [@{ kTitleKey : @"End Date",
                                       kDateKey : self.endDateTime ?: [NSDate date] } mutableCopy];
    
    NSArray *quickLinks = @[@{kTitleKey : @"Last Hour"}, @{kTitleKey : @"Last Day"}, @{kTitleKey : @"Last Week"}];

    self.tableContents = @[@[itemOne], @[itemTwo], quickLinks];
    
    UITableViewCell *pickerViewCellToCheck = [self.tableView dequeueReusableCellWithIdentifier:kDatePickerID];
    self.pickerCellRowHeight = CGRectGetHeight(pickerViewCellToCheck.frame);
    

}


- (BOOL)datePickerIsShown {
    return self.datePickerIndexPath != nil;
}


#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableContents.count;
}


- (void)hideExistingPicker {
    [self.tableView deleteRowsAtIndexPaths:@[self.datePickerIndexPath]
                          withRowAnimation:UITableViewRowAnimationFade];
    self.datePickerIndexPath = nil;
}

- (void)showNewPickerAtIndex:(NSIndexPath *)indexPath {
    [self.tableView insertRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationFade];
     self.datePickerIndexPath = indexPath;
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat rowHeight = self.tableView.rowHeight;
    
    if ([self datePickerIsShown] && indexPath.section < 2 && indexPath.row == 1) {
        rowHeight = self.pickerCellRowHeight;
    }
    
    return rowHeight;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableContents[section] count] + ((self.datePickerIndexPath != nil && self.datePickerIndexPath.section == section) ? 1 :0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section < 2) {
        NSDictionary *sectionData = self.tableContents[indexPath.section][0];
        if (indexPath.row == 0){
            cell = [self.tableView dequeueReusableCellWithIdentifier:kDateCellID];
            cell.textLabel.text = sectionData[kTitleKey];
            cell.detailTextLabel.text = [self.dateFormatter stringFromDate:sectionData[kDateKey]];
        } else if (indexPath.row == 1) {
            cell = [self.tableView dequeueReusableCellWithIdentifier:kDatePickerID];
            UIDatePicker *targetedDatePicker = (UIDatePicker *)[cell viewWithTag:kDatePickerTag];
            [targetedDatePicker setDate:sectionData[kDateKey] animated:NO];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        NSDictionary *sectionData = self.tableContents[indexPath.section][indexPath.row];
        cell = [self.tableView dequeueReusableCellWithIdentifier:kQuickLinkID];
        cell.textLabel.text = sectionData[kTitleKey];
    }
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView beginUpdates];
    
    if (indexPath.section < 2) {
        if (indexPath.row == 0) {
            NSIndexPath *datePickerIndexPath = self.datePickerIndexPath;
            
            if ([self datePickerIsShown]) {
                [self hideExistingPicker];
            }
            
            if (datePickerIndexPath == nil || datePickerIndexPath.section != indexPath.section) {
                NSIndexPath *newPickerIndexPath = [NSIndexPath indexPathForRow:1 inSection:indexPath.section];
                [self showNewPickerAtIndex:newPickerIndexPath];
            }
        }
       
    } else {
        NSDate *now = [NSDate date];
        if (indexPath.row == 0) {
            [self updateToLastHourFromDate:now];
        } else if (indexPath.row == 1) {
            [self updateToLastDayFromDate:now];
        } else if (indexPath.row == 2) {
            [self updateToLastWeekFromDate:now];
        }
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.tableView endUpdates];
}


- (void)updateToLastHourFromDate:(NSDate *)date  {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setHour:-1];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:date options:0];
    [self updateStartDate:newDate endDate:date];
}

- (void)updateToLastDayFromDate:(NSDate *)date {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:-1];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:date options:0];
    [self updateStartDate:newDate endDate:date];

}

- (void)updateToLastWeekFromDate:(NSDate *)date {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setWeekOfYear:-1];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:date options:0];
    [self updateStartDate:newDate endDate:date];
}

- (void)updateStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    if ([self datePickerIsShown]) {
        [self hideExistingPicker];
    }
    self.tableContents[0][0][kDateKey] = startDate;
    self.tableContents[1][0][kDateKey] = endDate;
    [self updateDates];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]
                  withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (IBAction)dateAction:(UIDatePicker *)sender {
    if ([self datePickerIsShown]) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:self.datePickerIndexPath.section]];
        cell.detailTextLabel.text = [self.dateFormatter stringFromDate:sender.date];
        self.tableContents[self.datePickerIndexPath.section][0][kDateKey] = sender.date;
        [self updateDates];
    }
}

- (void)updateDates {
    self.startDateTime = self.tableContents[0][0][kDateKey];
    self.endDateTime = self.tableContents[1][0][kDateKey];
}

#pragma Delegate Callbacks

- (IBAction)cancel:(id)sender {
    [self.delegate configViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender {
    [self.delegate configViewControllerDidFinish:self withStartDateTime:self.startDateTime endDateTime:self.endDateTime];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
