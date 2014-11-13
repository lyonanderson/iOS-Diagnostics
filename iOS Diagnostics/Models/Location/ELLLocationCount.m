//
//  ELLLocationCount.m
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 08/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import "ELLLocationCount.h"

@interface ELLLocationCount()
@property (nonatomic, readwrite, copy) NSString *client;
@property (nonatomic, readwrite, copy) NSString *type;
@property (nonatomic, readwrite, assign) NSUInteger count;
@end

@implementation ELLLocationCount

- (instancetype)initWithClient:(NSString *)client type:(NSString *)type count:(NSUInteger)count {
    self = [super init];
    if (self) {
        _client = [client copy];
        _type = [type copy];
        _count = count;
    }
    return self;
}

+ (instancetype)locationCountWithClient:(NSString *)client  type:(NSString *)type count:(NSUInteger)count {
   return [[ELLLocationCount alloc] initWithClient:client type:type count:count];
}

@end
