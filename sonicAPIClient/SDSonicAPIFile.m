//
//  SDSonicAPIFile.m
//  sonicAPIClient
//
//  Created by Maik Mann on 20.06.13.
//  Copyright (c) 2013 Maik Mann. All rights reserved.
//

#import "SDSonicAPIFile.h"

@implementation SDSonicAPIFile

-(id)initWithFilePath:(NSString*) filePath
{
    self = [self init];
    filePath_ = filePath;
    fileID_ = @"";
    return self;
}

- (NSString*) getFilePath
{
    return filePath_;
}
@end
