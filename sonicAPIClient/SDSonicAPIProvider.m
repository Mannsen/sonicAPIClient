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

-(NSMutableURLRequest*) buildRequest:(SDSonicAPITask*)task
{
    //build url
    NSString* url = [[NSString alloc] initWithString: baseURL_];
    url = [url stringByAppendingString:[SDSonicAPITask getURLForTask:[currentTask_ taskType_]]];
    url = [url stringByAppendingString:@"?access_id="];
    url = [url stringByAppendingString: accessID_];
    
    if( ([task taskType_] != Task_Upload_File) && [currentTask_ respondsToSelector:@selector(fileID_)])
    {
        url = [url stringByAppendingString:@"&input_file="];
        url = [url stringByAppendingString: [currentTask_ fileID_]];
    }

    //build request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    
    //if file upload task at binary data
    if([task taskType_] == Task_Upload_File)
    {
        NSData* postData = [self buildHTTPBody:currentTask_];
        // build post data and append it to http request
        [request setHTTPBody: postData ];
    
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary_];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        NSString *contentLength = [NSString stringWithFormat:@"%ld", [postData length]];
        [request addValue:contentLength forHTTPHeaderField: @"Content-Length"];
    }
    return request;
}

- (NSData*) buildHTTPBody:(SDSonicAPITask*)task
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

-(NSData*) doTask:(SDSonicAPITask*)task
{
    currentTask_ = task;
    currentDelegate_ = nil;
    
    NSMutableURLRequest* request = [self buildRequest:task];
    NSData* result = [connectionHandler_ sendRequestSynchronously:request];
    
    return result;    
}

-(void) doTask:(SDSonicAPITask*)task inform:(id <SDSonicAPITask_CallbackDelegate>) delegate
{
    currentTask_ = task;
    currentDelegate_ = delegate;
    
    NSMutableURLRequest* request = [self buildRequest:task];
    [connectionHandler_ sendRequestAsynchronously:request];
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
    NSLog(@"Init SonicAPIProvider");
    if(self = [self init])
    {
        self->accessID_ = accessID;
    }
    return self;
}

- (void) sucessfullyRequestResponse:(NSData *)responseData
{
    [currentTask_ setResult: responseData];
    [currentDelegate_ taskSuccessfullyDone: currentTask_];
}

- (void)  failedRequestResponse:(NSString*) errorDescription;

{
    [currentDelegate_ taskFailed:currentTask_ withError: errorDescription];
}

- (NSString*) getValueFromXMLData: (NSData*) xmlData forKey:(NSString*)key
{
    
    NSError* xmlParseError;
    NSXMLDocument* xmlResult = [[NSXMLDocument alloc] initWithData:xmlData options:NSXMLDocumentTidyXML error:&xmlParseError];
    
    NSArray* childs = [[xmlResult rootElement] children];
    
    for( NSXMLElement* child in childs )
    {
        NSXMLNode* node;
        if( (node = [child attributeForName: key]) != nil )
        {
            return [node objectValue];
        }
    }
    
    return @"";
}

@end
