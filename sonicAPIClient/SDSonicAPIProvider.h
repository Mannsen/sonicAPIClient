//
//  SDSonicAPIProvider.h
//  sonicAPIClient
//
//  Created by Maik Mann on 08.03.13.
//  Copyright (c) 2013 Maik Mann. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SDSonicAPITask.h"
#import "SDSonicAPIConnectionHandler.h"

@protocol SDSonicAPITask_CallbackDelegate <NSObject>

-(void) taskSuccessfullyDone: (SDSonicAPITask*) task;
-(void) taskFailed: (SDSonicAPITask*) task withError:(NSString*) errorDescription;

@end

@interface SDSonicAPIProvider : NSObject <SDSonicAPIConnectionHandler_CallbackDelegate>
{
    enum Error_t
    {
        Error_No_Connection,
        Error_Unknown
    };
    
    NSString* baseURL_;
    NSString* accessID_;
    NSString *boundary_;
    SDSonicAPIConnectionHandler* connectionHandler_;
    
    SDSonicAPITask* currentTask_;
    id<SDSonicAPITask_CallbackDelegate> currentDelegate_;
}

- (id)      init;
- (id)      initWithAccessID:(NSString*)accessID;

- (NSData*) doTask:(SDSonicAPITask*)task;
- (void)    doTask:(SDSonicAPITask*)task inform:(id <SDSonicAPITask_CallbackDelegate>) delegate;

// THIS SHOULD BE PRIVATE - (NSMutableURLRequest*) buildRequest:(SDSonicAPITask*)task;
// THIS SHOULD BE PRIVATE - (NSData*) buildHTTPBody:(SDSonicAPITask*)task;

// connection handler response callback
- (void)    sucessfullyRequestResponse:(NSData *) responseData;
- (void)    failedRequestResponse: (NSString*) errorDescription;

- (NSString*) getValueFromXMLData: (NSData*) xmlData forKey:(NSString*)key;


@end
