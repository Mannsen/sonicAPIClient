//
//  SDAppDelegate.h
//  sonicAPIClient
//
//  Created by Maik Mann on 23.10.12.
//  Copyright (c) 2012 Maik Mann. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SDSonicAPIProvider.h"

@interface SDAppDelegate : NSObject <NSApplicationDelegate, SDSonicAPITask_CallbackDelegate>
{
    SDSonicAPIProvider* m_pSApiP;
}

@property (assign) IBOutlet NSWindow *window;

-(void) taskSuccessfullyDone: (SDSonicAPITask*) task;
-(void) taskFailed: (SDSonicAPITask*) task withError:(NSString*) errorDescription;

@end
