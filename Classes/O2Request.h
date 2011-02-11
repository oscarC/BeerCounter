//
//  O2Request.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/10/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface O2Request : NSObject {
	NSMutableDictionary *parsedData;
@private
	NSURL *url;
	NSURLRequest *request;
	NSURLConnection *connection;
	NSMutableData *receivedData;
}

@property (nonatomic, retain) NSURL *url;
@property (nonatomic, retain) NSURLRequest *request;
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableData *receivedData;

+ (O2Request *) request;
- (void) post:(NSString *)method withData:(NSDictionary *)data;
- (void) get:(NSString *)method withData:(NSDictionary *)data;
- (NSString *) paramsToString:(NSDictionary *)data;
- (void) createRequest:(NSString *)type withParms:(NSString *)params;
- (NSDictionary *) data;

@end
