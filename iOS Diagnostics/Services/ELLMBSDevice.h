//
//  ELLMBSDevice.h
//  ELPowerLog
//
//  Created by Christopher Anderson on 12/01/2014.
//  Copyright (c) 2014 Electric Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBSDevice : NSObject {
    
    
}

@property (retain) NSMutableDictionary * deviceInfoDictionary;              //@synthesize deviceInfoDictionary=_deviceInfoDictionary - In the implementation block
@property (retain) NSData * logData;                                        //@synthesize logData=_logData - In the implementation block
@property (retain) NSString * logFileName;                                  //@synthesize logFileName=_logFileName - In the implementation block
-(void)dealloc;
-(id)deviceInfoDictionary;
-(BOOL)archiveLogFile:(id)arg1 toFile:(id)arg2 atDir:(id)arg3 ;
-(id)collectBasicDeviceData;
-(id)collectGasGaugeData;
-(id)collectAggdData;
-(id)collectUbiquityData;
-(void)setDeviceInfoDictionary:(NSMutableDictionary *)arg1 ;
-(BOOL)createTempDirectory:(unsigned)arg1 ;
-(BOOL)copyLogsToTempDirectory:(unsigned)arg1 ;
-(void)setLogFileName:(NSString *)arg1 ;
-(id)logFileName;
-(void)setLogData:(NSData *)arg1 ;
-(BOOL)copyPowerLogsToDir:(id)arg1 ;
-(BOOL)collectAllDeviceInformation;
-(BOOL)collectLogs:(unsigned)arg1 ;
-(id)logData;
@end