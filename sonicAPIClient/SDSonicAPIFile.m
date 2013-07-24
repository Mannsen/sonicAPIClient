//
//  SDSonicAPIFile.m
//  sonicAPIClient
//
//  Created by Maik Mann on 20.06.13.
//  Copyright (c) 2013 Maik Mann. All rights reserved.
//

#import "SDSonicAPIFile.h"

@implementation SDSonicAPIFile

- (id) initWithFilePath:(NSString*) filePath;
{
    return [self initWithFilePath:filePath SonicAPIProvider:nil];
}

- (id) initWithFilePath:(NSString*) filePath SonicAPIProvider:(SDSonicAPIProvider*) sonicAPIProvider
{
    self = [self init];
    
    filePath_ = filePath;
    fileID_ = @"";
    fileStatus_ = File_Local;
    
    sonicAPIProvider_ = sonicAPIProvider;
    
    return self;
}

- (NSString*) getFilePath
{
    return filePath_;
}

- (NSString*) getFileID
{
    return fileID_;
}

- (void) setFileID: (NSString*) fileID
{
    fileID_ = fileID;
}

- (bool) synhronizeWithAPI
{
    if(sonicAPIProvider_ == nil)
    {
        return false;
    }
    
    if([self getFileStatus] == File_Local)
    {
        SDSonicAPIUploadFileTask* fuTask = [[SDSonicAPIUploadFileTask alloc] initTaskWithPath:[self getFilePath]];
        NSData* result =[sonicAPIProvider_ doTask:fuTask];
        [self setFileID: [sonicAPIProvider_ getValueFromXMLData:result forKey:@"file_id"]];
    }
    else if(*[self getFileStatus] == File_Local_And_Remoted)
    {
        //Needed to implement
    }
    
    return true;
}

- (NSXMLDocument*) analyzeFile: (enum AnalyzeTask_t) analyzeTask;
{
    SDSonicAPIAnalyzeFileTask* task = [SDSonicAPIAnalyzeFileTask alloc];
    switch (analyzeTask) {
        case Analyze_Key:
            [task initWithFileID:[self getFileID] analyzeTask:Task_Analyze_Key];
            break;
        case Analyze_Loudness:
            [task initWithFileID:[self getFileID] analyzeTask:Task_Analyze_Loudness];
            break;
        case Analyze_Melody:
            [task initWithFileID:[self getFileID] analyzeTask:Task_Analyze_Melody];
            break;
        case Analyze_Tempo:
            [task initWithFileID:[self getFileID] analyzeTask:Task_Analyze_Tempo];
            break;
    }
    
    //[sonicAPIProvider_ doTask:task inform:self];
    
    
    NSData* result = [sonicAPIProvider_ doTask:task];
    NSError* xmlParseError;
    
    //NSLog(@"%@", [[NSString init] initWithData: result]);
    
    return [[NSXMLDocument alloc] initWithData:result options:NSXMLDocumentTidyXML error:&xmlParseError];
    
    
    return nil;
}

- (enum FileStatus_t*) getFileStatus
{
    return fileStatus_;
}
@end
