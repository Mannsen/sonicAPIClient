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

    self.file = [[SDSonicAPIFile alloc] initWithFilePath:@"/Users/maikmann/Desktop/ApiTest.mp3" SonicAPIProvider:m_pSApiP];
    
    
    /*** WITH File Class **/
    
    if([self.file synhronizeWithAPI])
    {
        NSXMLDocument* document = [self.file analyzeFile:Analyze_Key];        
        NSLog(@"%@", document);
        document = [self.file analyzeFile:Analyze_Tempo];
        NSLog(@"%@", document);
        document = [self.file analyzeFile:Analyze_Melody];
        NSLog(@"%@", document);
        document = [self.file analyzeFile:Analyze_Loudness];
        NSLog(@"%@", document);
    }
   
   
    /*** Direct with Tasks an SonicAPIProvider ***/
    //SDSonicAPIUploadFileTask* fuTask = [[SDSonicAPIUploadFileTask alloc] initTaskWithPath:[self.file getFilePath]];
    
    
    /**** Asynchron ****/
    //[m_pSApiP doTask:fuTask inform:self];
    
    /**** Synchron ****/
    //NSData* result = [m_pSApiP doTask:fuTask];
    //NSError* xmlParseError;
    //NSXMLDocument* xmlResult = [[NSXMLDocument alloc] initWithData:result options:NSXMLDocumentTidyXML error:&xmlParseError];
    //NSLog(@"%@", [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding]);
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
    NSLog(@"Task Failed: %@", errorDescription);
}


@end
