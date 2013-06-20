//
//  SDSonicAPIFile.h
//  sonicAPIClient
//
//  Created by Maik Mann on 20.06.13.
//  Copyright (c) 2013 Maik Mann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDSonicAPIFile : NSObject
{
   NSString* filePath_;
   NSString* fileID_;
}

- (id) initWithFilePath:(NSString*) filePath;
- (NSString*) getFilePath;

@end
