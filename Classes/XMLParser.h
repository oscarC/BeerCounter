//
//  XMLParser.h
//  FoursquareList
//
//  Created by Oscar De Moya on 2/4/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface XMLParser : NSObject {
    NSMutableArray *items;
    User *entityInProgress;
    NSString *keyInProgress;
    NSString *textInProgress;
}

- (BOOL)parseData:(NSData *)d;
- (NSArray *)items;

@end
