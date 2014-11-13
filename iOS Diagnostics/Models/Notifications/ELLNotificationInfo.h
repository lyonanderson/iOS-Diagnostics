//
//  ELLNotificationInfo.h
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 10/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELLNotificationInfo : NSObject

@property (nonatomic, readonly, copy) NSString *connectionType;
@property (nonatomic, readonly, assign) NSDate *timestamp;

+ (instancetype)infoWithConnectionType:(NSString *)connectionType timestamp:(NSDate *)timestamp;


@end
