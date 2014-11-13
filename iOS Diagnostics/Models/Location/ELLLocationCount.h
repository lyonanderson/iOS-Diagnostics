//
//  ELLLocationCount.h
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 08/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELLLocationCount : NSObject

@property (nonatomic, readonly, copy) NSString *client;
@property (nonatomic, readonly, copy) NSString *type;
@property (nonatomic, readonly, assign) NSUInteger count;

+ (instancetype)locationCountWithClient:(NSString *)client  type:(NSString *)type count:(NSUInteger)count;

@end
