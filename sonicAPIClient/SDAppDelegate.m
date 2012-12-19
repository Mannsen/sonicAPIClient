//
//  SDAppDelegate.m
//  sonicAPIClient
//
//  Created by Maik Mann on 23.10.12.
//  Copyright (c) 2012 Maik Mann. All rights reserved.
//

#import "SDAppDelegate.h"

@implementation SDAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    [self sendUpLoadRequest];
    //[self sendBlockingAPIRequest];

}
- (void) sendBlockingAPIRequest
{
    NSLog(@"sendBlockingAPIRequest");
    
    NSString* url = @"http://api.sonicapi.com/analyze/key?access_id=a43d2e2e-817d-4602-b649-9858e959d8cc&input_file=http://www.sonicapi.com/music/brown_eyes_by_ueberschall.mp3";
    //NSURLRequest* request = [[NSURLRequest alloc] initWithURL: [NSURL URLWithString:url]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setTimeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    
    NSURLConnection* connection =  [[NSURLConnection alloc] init ];
    connection = [connection initWithRequest:request delegate:self startImmediately:true];
}

- (void) sendUpLoadRequest
{
    NSLog(@"sendUpLoadRequest");
    NSString* url = @"http://api.sonicapi.com/file/upload?access_id=a43d2e2e-817d-4602-b649-9858e959d8cc";
    
    NSData* file = [[NSData alloc] initWithContentsOfFile:@"/Users/maikmann/Desktop/ApiTest.mp3"];
    NSString* filename = @"ApiTest.mp3";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    
         
    NSString *boundary = [NSString stringWithString:@"----------------------------cb8bd90f140f"];
    NSMutableData *postData = [[NSMutableData alloc] init];
   
    [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n", filename]dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"Content-Type: audio\r\n" ] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithString:@"Content-Transfer-Encoding: binary\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postData appendData: [NSData dataWithData:file]];
    [postData appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postData appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
       // Append
    [request setHTTPBody:postData ];
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSString *contentLength = [NSString stringWithFormat:@"%ld", [postData length]];
    [request addValue:contentLength forHTTPHeaderField: @"Content-Length"];
    
    NSURLConnection* connection =  [[NSURLConnection alloc] initWithRequest:request delegate:self];
   
}

- (NSInputStream *)connection:(NSURLConnection *)connection needNewBodyStream:(NSURLRequest *)request
{
    NSLog(@"needNewBodyStream");
}


- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSLog(@"willSendRequestForAuthenticationChallenge");
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
