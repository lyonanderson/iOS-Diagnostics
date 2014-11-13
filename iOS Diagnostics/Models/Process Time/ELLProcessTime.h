//
//  ELLProcessTime.h
//  iOS Diagnostics
//
//  Created by Christopher Anderson on 09/11/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELLProcessTime : NSObject

@property (nonatomic, readonly, copy) NSString *processName;
@property (nonatomic, readonly, assign) NSTimeInterval processTime;

+ (instancetype)processTimeWithName:(NSString *)processName processTime:(NSTimeInterval)processTime;

@end
