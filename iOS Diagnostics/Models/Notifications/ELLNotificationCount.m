//
//  ELLNotificationCount.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 06/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLNotificationCount.h"

@implementation ELLNotificationCount

- (instancetype)initWithTopic:(NSString *)topic count:(NSUInteger)count {
    self = [super init];
    if (self) {
        _topic = [topic copy];
        _count = count;
    }
    return self;
}

+ (instancetype) notificationCountWithTopic:(NSString *)topic count:(NSUInteger)count {
   return [[ELLNotificationCount alloc] initWithTopic:topic count:count];
}

@end
