//
//  SDSonicAPIConnectionHandler.h
//  sonicAPIClient
//
//  Created by Maik Mann on 08.03.13.
//  Copyright (c) 2013 Maik Mann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDSonicAPIConnectionHandler : NSObject <NSURLConnectionDelegate>
{
    NSHTTPURLResponse* lastReceivedResonse;
}


- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;


- (NSInputStream *)connection:(NSURLConnection *)connection needNewBodyStream:(NSURLRequest *)request;
- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse;
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite;

@end
