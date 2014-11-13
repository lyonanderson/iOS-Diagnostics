//
//  ELLConfigViewController.h
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 07/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ELLConfigViewController;

@protocol ELLConfigViewControllerDelegate
- (void)configViewControllerDidFinish:(ELLConfigViewController *)configViewController withStartDateTime:(NSDate *)startDateTime endDateTime:(NSDate *)endDateTime;
- (void)configViewControllerDidCancel:(ELLConfigViewController *)configViewController;
@end

@interface ELLConfigViewController : UIViewController

@property (nonatomic, copy) NSDate *startDateTime;
@property (nonatomic, copy) NSDate *endDateTime;

@property (nonatomic, weak) id<ELLConfigViewControllerDelegate> delegate;

@end
