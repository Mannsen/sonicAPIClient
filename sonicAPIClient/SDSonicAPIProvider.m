//
//  SDSonicAPIProvider.m
//  sonicAPIClient
//
//  Created by Maik Mann on 08.03.13.
//  Copyright (c) 2013 Maik Mann. All rights reserved.
//

#import "SDSonicAPIProvider.h"

#import "SDSonicAPIConnectionHandler.h"

@implementation SDSonicAPIProvider


- (void) sendUpLoadRequest
{
    
    
    NSLog(@"sendUpLoadRequest");
    NSString* url = @"https://api.sonicapi.com/file/upload?access_id=a43d2e2e-817d-4602-b649-9858e959d8cc";
    
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

@end
