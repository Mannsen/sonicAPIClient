//
//  SDAppDelegate.h
//  sonicAPIClient
//
//  Created by Maik Mann on 23.10.12.
//  Copyright (c) 2012 Maik Mann. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SDSonicAPIProvider.h"

@interface SDAppDelegate : NSObject <NSApplicationDelegate>
{
    SDSonicAPIProvider* m_pSApiP;
}

@property (assign) IBOutlet NSWindow *window;


- (void) sendBlockingAPIRequest;
- (void) sendUpLoadRequest;





@end
