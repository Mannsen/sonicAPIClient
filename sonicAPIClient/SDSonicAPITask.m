//
//  SDSonicAPITask.m
//  sonicAPIClient
//
//  Created by Maik Mann on 08.03.13.
//  Copyright (c) 2013 Maik Mann. All rights reserved.
//

#import "SDSonicAPITask.h"

@implementation SDSonicAPITask

+ (NSString*) getURLForTask:(enum Task_t)task_t
{
    NSString* url;
    
    switch (task_t) {
        case Task_Upload_File:
            url = @"/file/upload";
            break;
        case Task_Download_File:
            url = @"/file/download";
            break;
        case Task_Process_Elastique:
            url = @"/process/elastique";
            break;
        case Task_Process_ElastiqueTune:
            url = @"/process/elastiqueTune";
            break;
        case Task_Process_Reverb:
            url = @"/process/reverb";
            break;
        case Task_Analyze_Key:
            url = @"/analyze/key";
            break;
        case Task_Analyze_Loudness:
            url = @"/analyze/loudness";
            break;
        case Task_Analyze_Melody:
            url = @"/analyze/melody";
            break;
        case Task_Analyze_Tempo:
            url = @"/analyze/tempo";
            break;
    }
    
    return url;
}


@end

@implementation SDSonicAPIUploadFileTask

-(id)initWithPath:(NSString*) path
{
    self = [super init];
    
    if (self != NULL) {
        self.taskType_ = Task_Upload_File;
        self.filePath_ = path;
    }
    
    return self;
}

- (NSString*) getFileName
{
    NSURL* url = [[NSURL alloc] initWithString: self.filePath_];
    return [url lastPathComponent];
}

- (NSData*) getFileRawData
{
    fileData_ = [[NSData alloc] initWithContentsOfFile:self.filePath_];
    return fileData_;
}

-(NSData*) getResult
{
    return NULL;
}

@end

@implementation SDSonicAPIDownloadFileTask

- (id) init
{
    self = [super init];
    self.taskType_ = Task_Upload_File;
    return self;
}

-(id)initWithFileID:(NSString*) fileID
{
    self = [self init];
    self.fileID_ = fileID;
    return self;
}

-(NSData*) getResult;
{
    return NULL;
}

@end