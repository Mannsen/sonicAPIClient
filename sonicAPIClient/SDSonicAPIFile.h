//
//  SDSonicAPIFile.h
//  sonicAPIClient
//
//  Created by Maik Mann on 20.06.13.
//  Copyright (c) 2013 Maik Mann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDSonicAPIProvider.h"

@interface SDSonicAPIFile : NSObject
{
    enum FileError_t
    {
        File_No_Error,
        File_No_Provider_Set,
        File_Unkown_Error
    };
    
    enum FileStatus_t
    {
        File_Local,
        File_Local_And_Remoted,
        File_Remoted        
    } fileStatus_;
    
    enum AnalyzeTask_t
    {
        Analyze_Key,
        Analyze_Loudness,
        Analyze_Melody,
        Analyze_Tempo
    };
    
    NSString* filePath_;
    NSString* fileID_;
    SDSonicAPIProvider* sonicAPIProvider_;
    
}

- (id) initWithFilePath:(NSString*) filePath;
- (id) initWithFilePath:(NSString*) filePath SonicAPIProvider:(SDSonicAPIProvider*) sonicAPIProvider;
- (NSString*) getFilePath;
- (NSString*) getFileID;
- (void) setFileID: (NSString*) fileID;
- (enum FileStatus_t*) getFileStatus;
- (bool) synhronizeWithAPI;

- (NSXMLDocument*) analyzeFile: (enum AnalyzeTask_t) analyzeTask;

- (void) doTask;

@end
