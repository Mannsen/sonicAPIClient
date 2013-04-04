//
//  SDSonicAPIProvider.m
//  sonicAPIClient
//
//  Created by Maik Mann on 08.03.13.
//  Copyright (c) 2013 Maik Mann. All rights reserved.
//

#import "SDSonicAPIProvider.h"
#import "SDSonicAPITask.h"
#import "SDSonicAPIConnectionHandler.h"

@implementation SDSonicAPIProvider

-(void) doTask:(SDSonicAPITask*)task inform:(id <SDSonicAPITask_CallbackDelegate>) delegate
{
    currentTask_ = task;
    currentDelegate_ = delegate;
    
    NSString* url = [[NSString alloc] initWithString: baseURL_];
    url = [url stringByAppendingString:[SDSonicAPITask getURLForTask:[currentTask_ taskType_]]];
    url = [url stringByAppendingString:@"?access_id="];
    url = [url stringByAppendingString: accessID_];
   
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    
    NSData* postData = [self buildRequestBody:currentTask_];
    // build post data and append it to http request
    [request setHTTPBody: postData ];
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary_];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSString *contentLength = [NSString stringWithFormat:@"%ld", [postData length]];
    [request addValue:contentLength forHTTPHeaderField: @"Content-Length"];
    
    [connectionHandler_ sendRequest:request];

}

-(void) doTask:(SDSonicAPITask*)task onFileWithID:(NSString*)fileID inform:(id <SDSonicAPITask_CallbackDelegate>) delegate
{

}

- (NSData*) buildRequestBody:(SDSonicAPITask*)task
{
    NSMutableData *postData = [[NSMutableData alloc] init];
    
    [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary_] dataUsingEncoding:NSUTF8StringEncoding]];
    
    if([task taskType_] == Task_Upload_File)
    {
        [postData appendData: [[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n", [(SDSonicAPIUploadFileTask*)task getFileName] ]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[@"Content-Type: audio\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[@"Content-Transfer-Encoding: binary\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        [postData appendData:[NSData dataWithData: [(SDSonicAPIUploadFileTask*)task getFileRawData]]];
        [postData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [postData appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary_] dataUsingEncoding:NSUTF8StringEncoding]];
    
    return postData;
}

-(id) init
{
    if(self = [super init])
    {
        self->baseURL_      = @"https://api.sonicapi.com";
        self->accessID_     = @"";
        self->boundary_     = @"----------------------------cb8bd90f140f";
        connectionHandler_  = [[SDSonicAPIConnectionHandler alloc] initWithResponseDelegate: self];
    }
    return self;
}

-(id) initWithAccessID:(NSString*)accessID
{
    if(self = [self init])
    {
        self->accessID_ = accessID;
    }
    return self;
}

- (void) sucessfullyRequestResponse:(NSData *)responseData
{
    [currentTask_ setResult_: responseData];
    [currentDelegate_ taskSuccessfullyDone: currentTask_];
}

- (void) failedRequestResponse
{
    [currentDelegate_ taskFailed:currentTask_ withError:@"fuck off  "];
}

@end
