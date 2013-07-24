//
//  SDSonicAPIConnectionHandler.m
//  sonicAPIClient
//
//  Created by Maik Mann on 08.03.13.
//  Copyright (c) 2013 Maik Mann. All rights reserved.
//

#import "SDSonicAPIConnectionHandler.h"

@implementation SDSonicAPIConnectionHandler

- (id) initWithResponseDelegate:(id<SDSonicAPIConnectionHandler_CallbackDelegate>) delegate
{
    if (self = [self init])
    {
        responseDelegate_ = delegate;
    }
    
    return self;
}

- (void) sendRequestAsynchronously:(NSMutableURLRequest*) request
{
    connection_ =  [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (NSData*) sendRequestSynchronously:(NSMutableURLRequest*) request
{
    NSURLResponse* response;
    NSError* connectionError;
    NSData* result = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error: &connectionError];
    
    return result;
}

- (NSInputStream *)connection:(NSURLConnection *)connection needNewBodyStream:(NSURLRequest *)request
{
    return NULL;
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return false;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if ( responseDelegate_ != NULL)
    {
        [responseDelegate_  failedRequestResponse: [error domain]];
    }
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse;
{
    return NULL;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    lastReceivedResonse_ = response;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    internalResponseCache_ = data;
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse
{
    return request;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if ( responseDelegate_ != NULL)
    {
        [responseDelegate_  sucessfullyRequestResponse:internalResponseCache_];
    }
}
- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    //NSLog(@"%f loaded", ((float)totalBytesWritten/(float)totalBytesExpectedToWrite)*100);
}



@end
