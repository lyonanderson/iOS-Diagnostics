//
//  ELLNotificationCount.h
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 06/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELLNotificationCount : NSObject

@property (nonatomic, copy) NSString *topic;
@property (nonatomic, assign) NSUInteger count;

+ (instancetype) notificationCountWithTopic:(NSString *)topic count:(NSUInteger)count;

@end
