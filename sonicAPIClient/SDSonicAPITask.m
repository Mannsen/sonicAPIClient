//
//  SDSonicAPITask.m
//  sonicAPIClient
//
//  Created by Maik Mann on 08.03.13.
//  Copyright (c) 2013 Maik Mann. All rights reserved.
//

#import "SDSonicAPITask.h"

@implementation SDSonicAPITask

@end

@implementation SDSonicAPIUploadFileTask

-(void)initWithPath:(NSString*) path
{
    m_filePath = path;
}

-(NSData*) getResult
{
    return NULL;
}

@end

@implementation SDSonicAPIDownloadFileTask

-(void)initWithFileID:(NSString*) fileID
{
    m_fileID = fileID;
}

-(NSData*) getResult;
{
    return NULL;
}

@end