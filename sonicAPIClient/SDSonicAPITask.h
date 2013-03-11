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
        Task_Analyze_Tempo,
        
        Task_NumOfTasks
        
    };

    NSData* result;
    
}

+(SDSonicAPITask*) getTaskForType: (enum Task_t)type;

-(NSData*) getResult;

@end

@interface SDSonicAPIUploadFileTask: SDSonicAPITask
{
    NSString* m_filePath;
}

-(void)initWithPath:(NSString*) path;
-(NSData*) getResult;

@end

@interface SDSonicAPIDownloadFileTask: SDSonicAPITask
{
    NSString* m_fileID;
}

-(void)initWithFileID:(NSString*) fileID;
-(NSData*) getResult;

@end