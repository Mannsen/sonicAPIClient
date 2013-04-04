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
    m_pSApiP = [[SDSonicAPIProvider alloc] initWithAccessID:@"a43d2e2e-817d-4602-b649-9858e959d8cc"];
    SDSonicAPIUploadFileTask* fuTask = [[SDSonicAPIUploadFileTask alloc] initWithPath:@"/Users/maikmann/Desktop/ApiTest.mp3"];
    
    [m_pSApiP doTask:fuTask inform:self];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
}

-(void) taskSuccessfullyDone: (SDSonicAPITask*) task
{
    NSString* resultString = [[NSString alloc] initWithCString: [[task result_] bytes] encoding: NSUTF8StringEncoding];
    NSLog(@"%@", resultString);
}

-(void) taskFailed: (SDSonicAPITask*) task withError:(NSString*) errorDescription
{
    NSLog(@"somethings wrong");
}


//- (void) sendBlockingAPIRequest
//{
//    NSLog(@"sendBlockingAPIRequest");
//    
//    NSString* url = @"https://api.sonicapi.com/analyze/key?access_id=a43d2e2e-817d-4602-b649-9858e959d8cc&input_file=http://www.sonicapi.com/music/brown_eyes_by_ueberschall.mp3";
//    //NSURLRequest* request = [[NSURLRequest alloc] initWithURL: [NSURL URLWithString:url]];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setURL:[NSURL URLWithString:url]];
//    [request setTimeoutInterval:10.0];
//    [request setHTTPMethod:@"POST"];
//    
//    NSURLConnection* connection =  [[NSURLConnection alloc] init ];
//    connection = [connection initWithRequest:request delegate:self startImmediately:true];
//}
//
//- (void) sendUpLoadRequest
//{
//    NSLog(@"sendUpLoadRequest");
//    NSString* url = @"https://api.sonicapi.com/file/upload?access_id=a43d2e2e-817d-4602-b649-9858e959d8cc";
//    
//    NSData* file = [[NSData alloc] initWithContentsOfFile:@"/Users/maikmann/Desktop/ApiTest.mp3"];
//    NSString* filename = @"ApiTest.mp3";
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setURL:[NSURL URLWithString:url]];
//    [request setHTTPMethod:@"POST"];
//    
//         
//    NSString *boundary = @"----------------------------cb8bd90f140f";
//    NSMutableData *postData = [[NSMutableData alloc] init];
//   
//    [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n", filename]dataUsingEncoding:NSUTF8StringEncoding]];
//    [postData appendData:[[NSString stringWithFormat:@"Content-Type: audio\r\n" ] dataUsingEncoding:NSUTF8StringEncoding]];
//    [postData appendData:[[NSString stringWithString:@"Content-Transfer-Encoding: binary\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    [postData appendData: [NSData dataWithData:file]];
//    [postData appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    [postData appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    
//       // Append
//    [request setHTTPBody:postData ];
//    
//    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
//    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
//    NSString *contentLength = [NSString stringWithFormat:@"%ld", [postData length]];
//    [request addValue:contentLength forHTTPHeaderField: @"Content-Length"];
//    
//    NSURLConnection* connection =  [[NSURLConnection alloc] initWithRequest:request delegate:self];
//}

@end
