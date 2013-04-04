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
}

@property(nonatomic)        enum Task_t taskType_;
@property(nonatomic,assign) NSData*     result_;

+ (NSString*) getURLForTask:(enum Task_t)task_t;

@end

@interface SDSonicAPIUploadFileTask: SDSonicAPITask
{
    NSData* fileData_;
}

@property (nonatomic) NSString* filePath_;

- (id) initWithPath:(NSString*) path;
- (NSString*) getFileName;
- (NSData*) getFileRawData;
- (NSData*) getResult;

@end

@interface SDSonicAPIDownloadFileTask: SDSonicAPITask

@property (nonatomic) NSString* fileID_;

- (id) init;
- (id) initWithFileID:(NSString*) fileID;
- (NSData*) getResult;

@end