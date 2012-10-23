//
//  SDAppDelegate.m
//  sonicAPIClient
//
//  Created by Maik Mann on 23.10.12.
//  Copyright (c) 2012 Maik Mann. All rights reserved.
//

#import "SDAppDelegate.h"

void clientCB(CFReadStreamRef stream, CFStreamEventType event, void *myPtr)
{
     NSLog(@" clientCB");
    switch(event) {
        case kCFStreamEventHasBytesAvailable:{
            UInt8 buf[1024];
            CFIndex bytesRead = CFReadStreamRead(stream, buf, 1024);
            if (bytesRead > 0) {
                NSLog(@"Server has data to read! %i", bytesRead);
                NSString* byteString = [[NSString alloc] initWithBytes:buf length:bytesRead encoding:NSASCIIStringEncoding ];
                NSLog(byteString);
            }
            break;
        }
        case kCFStreamEventErrorOccurred:
            NSLog(@"A Read Stream Error Has Occurred!");
        case kCFStreamEventEndEncountered:
            NSLog(@"A Read Stream Event End!");
        default:
            break;
    }
    
}

@implementation SDAppDelegate


- (void) streamCallBack:(CFReadStreamRef) stream event:(CFStreamEventType)event myPtr:(void *)myPtr
{
    NSLog(@" streamCallBack");
    
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    NSString* accessID = @"a43d2e2e-817d-4602-b649-9858e959d8cc";
    NSString* $taskUrl = @"analyze/key";
    
   
    CFStringRef url = CFSTR("https://api.sonicAPI.com/analyze/key");
    CFURLRef myURL = CFURLCreateWithString(kCFAllocatorDefault, url, NULL);
    CFStringRef requestMethod = CFSTR("POST");
    CFStringRef bodyString = CFSTR("blocking=true&access_id=a43d2e2e-817d-4602-b649-9858e959d8cc&format=json&input_file=http://beta:gFSeULWzlw1@sonicAPI.com/music/brown_eyes_by_ueberschall.mp3");
        
    CFDataRef bodyData = CFStringCreateExternalRepresentation(kCFAllocatorDefault, bodyString, kCFStringEncodingUTF8, 0);
    CFStringRef headerFieldName = CFSTR("");
    CFStringRef headerFieldValue = CFSTR("");
    
    CFHTTPMessageRef myRequest = CFHTTPMessageCreateRequest(kCFAllocatorDefault,requestMethod, myURL, kCFHTTPVersion1_0);
    CFHTTPMessageSetBody(myRequest, bodyData);
    CFHTTPMessageSetHeaderFieldValue(myRequest, headerFieldName, headerFieldValue);
    CFReadStreamRef myReadStream =CFReadStreamCreateForHTTPRequest(kCFAllocatorDefault, myRequest);
    
    CFOptionFlags registeredEvents = kCFStreamEventHasBytesAvailable | kCFStreamEventErrorOccurred | kCFStreamEventEndEncountered;
    CFStreamClientContext myContext = {
        0,
        (__bridge void *)(self),
        (void *(*)(void *info))CFRetain,
        (void (*)(void *info))CFRelease,
        (CFStringRef (*)(void *info))CFCopyDescription
    };

    if(CFReadStreamSetClient(myReadStream, registeredEvents, clientCB, &myContext))
    {
        CFReadStreamScheduleWithRunLoop(myReadStream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);
    }
    
    CFReadStreamOpen(myReadStream);    
}


@end
