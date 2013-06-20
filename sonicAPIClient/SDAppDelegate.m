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

    SDSonicAPIFile* file = [[SDSonicAPIFile alloc] initWithFilePath:@"/Users/maikmann/Desktop/ApiTest.mp3" ];
    SDSonicAPIUploadFileTask* fuTask = [[SDSonicAPIUploadFileTask alloc] initTaskWithFile:file];
    
    [m_pSApiP doTask:fuTask inform:self];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
}

-(void) taskSuccessfullyDone: (SDSonicAPITask*) task
{
    NSLog(@"something's good");
}

-(void) taskFailed: (SDSonicAPITask*) task withError:(NSString*) errorDescription
{
    NSLog(@"something's wrong");
}


@end
