//
//  ELLPowerLogDownloadService.h
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 06/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ELLPowerLogDownloadService;

@protocol ELLPowerLogDownloadServiceDelegate <NSObject>
- (void) powerLogDownloadService:(ELLPowerLogDownloadService *)downloadService didFinishWithSQLLogFiles:(NSArray *)sqlLogFiles compressedSQLFiles:(NSArray *)compressedSQLFiles;
- (void) powerLogDownloadService:(ELLPowerLogDownloadService *)downloadService didFailWithError:(NSError *)error;
@end

@interface ELLPowerLogDownloadService : NSObject

@property (nonatomic, weak) id<ELLPowerLogDownloadServiceDelegate> delegate;

- (void)startPowerLogDownload;

@end
