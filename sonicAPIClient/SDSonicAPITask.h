//
//  SDSonicAPITask.h
//  sonicAPIClient
//
//  Created by Maik Mann on 08.03.13.
//  Copyright (c) 2013 Maik Mann. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@property(atomic)    enum Task_t taskType_;
@property(retain)    NSString*   filePath_;

+ (NSString*) getURLForTask:(enum Task_t)task_t;
- (id) initTaskWithPath:(NSString*) file;
- (void) setResult:(NSData*) result;
- (NSData*) getResult;

@end

@interface SDSonicAPIUploadFileTask: SDSonicAPITask
{
    NSData* fileData_;
}

- (id) initTaskWithPath:(NSString*) filePath;

- (NSString*) getFileName;
- (NSData*) getFileRawData;
- (void) setResult:(NSData *)result;

@end

@interface SDSonicAPIDownloadFileTask: SDSonicAPITask

@property (assign, nonatomic) NSString* fileID_;

- (id) init;
- (id) initWithFileID:(NSString*) fileID;

@end

@interface SDSonicAPIAnalyzeFileTask: SDSonicAPITask

@property (assign, nonatomic) NSString* fileID_;

- (id) initWithFileID:(NSString*) fileID analyzeTask: (enum Task_t*) task;

@end