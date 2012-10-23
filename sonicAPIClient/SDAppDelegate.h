//
//  SDAppDelegate.h
//  sonicAPIClient
//
//  Created by Maik Mann on 23.10.12.
//  Copyright (c) 2012 Maik Mann. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SDAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

- (void) streamCallBack:(CFReadStreamRef) stream event:(CFStreamEventType)event myPtr:(void *)myPtr;

@end
