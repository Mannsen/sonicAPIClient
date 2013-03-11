//
//  SDSonicAPIProvider.h
//  sonicAPIClient
//
//  Created by Maik Mann on 08.03.13.
//  Copyright (c) 2013 Maik Mann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDSonicAPITask.h"


@protocol SDSonicAPITask_CallbackDelegate <NSObject>

-(void) taskSuccessfullyDone: (SDSonicAPITask*) task;
-(void) taskFailed: (SDSonicAPITask*) task withError:(NSString*) errorDescription;

@end


@interface SDSonicAPIProvider : NSObject
{


}

+ (void)     doTask:(SDSonicAPITask*) onFileAtPath:(NSString*)filePath inform:(id <SDSonicAPITask_CallbackDelegate>) delegate;
+ (void)     doTask:(SDSonicAPITask*) onFileWithID:(NSString*)fileID inform:(id <SDSonicAPITask_CallbackDelegate>) delegate;

- (BOOL*)     doTask:(SDSonicAPITask*) onFileAtPath:(NSString*) filePath ;
- (BOOL*)     doTask:(SDSonicAPITask*) onFileWithID:(NSString*) fileID ;



@end
