//
//  SDSonicAPIConnectionHandler.m
//  sonicAPIClient
//
//  Created by Maik Mann on 08.03.13.
//  Copyright (c) 2013 Maik Mann. All rights reserved.
//

#import "SDSonicAPIConnectionHandler.h"

@implementation SDSonicAPIConnectionHandler


- (NSInputStream *)connection:(NSURLConnection *)connection needNewBodyStream:(NSURLRequest *)request
{
    NSLog(@"needNewBodyStream");
}

/*
 - (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
 {
 NSLog(@"willSendRequestForAuthenticationChallenge");
 [performDefaultHandlingForAuthenticationChallenge challenge];
 }
 */
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return false;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog( [[error userInfo] description] );
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse;
{
    NSLog(@"1");
    return nil;
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"Received: Header");
    NSLog( [response MIMEType]);
    NSLog( [NSHTTPURLResponse localizedStringForStatusCode: [(NSHTTPURLResponse*)response statusCode ]]);
    lastReceivedResonse = response;
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"Received: Body");
    NSString* dataString = [NSString stringWithCString:[data bytes]];
    NSLog( dataString );
}
- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse
{
    NSLog(@"SEND Request to ");
    NSLog([[request URL] absoluteString]);
    
    return request;
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Finished Request");
}
- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    NSLog(@"%f loaded", ((float)totalBytesWritten/(float)totalBytesExpectedToWrite)*100);
}



@end
