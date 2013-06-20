//
//  SDSonicAPITask.h
//  sonicAPIClient
//
//  Created by Maik Mann on 08.03.13.
//  Copyright (c) 2013 Maik Mann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDSonicAPIFile.h"

@interface SDSonicAPITask: NSObject
{    
    enum Task_t
    {
        Task_Upload_File,
        Task_Download_File,        
        Task_Process_Elastique,
        Task_Process_ElastiqueTune,
        Task_Process_Reverb,
        Task_Analyze_Key,
        Task_Analyze_Loudness,
        Task_Analyze_Melody,
        Task_Analyze_Tempo       
    };
    
    NSData* result_;
    
}

@property(nonatomic)    enum Task_t taskType_;
@property(retain)       SDSonicAPIFile* file_;

+ (NSString*) getURLForTask:(enum Task_t)task_t;
- (id) initTaskWithFile:(SDSonicAPIFile*) file;
- (void) setResult:(NSData*) result;
- (NSData*) getResult;

@end

@interface SDSonicAPIUploadFileTask: SDSonicAPITask
{
    NSData* fileData_;
}

- (id) initTaskWithFile:(SDSonicAPIFile*) file;

- (NSString*) getFileName;
- (NSData*) getFileRawData;
- (void) setResult:(NSData *)result;

@end

@interface SDSonicAPIDownloadFileTask: SDSonicAPITask

@property (nonatomic) NSString* fileID_;

- (id) init;
- (id) initWithFileID:(NSString*) fileID;

@end