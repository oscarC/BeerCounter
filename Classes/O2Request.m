//
//  O2Request.m
//  BeerCounter
//
//  Created by Oscar De Moya on 2/10/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "O2Request.h"
#import "AppConfig.h"
#import "JSON.h"


@implementation O2Request

@synthesize url, request, connection, receivedData;

+ (O2Request *) request {
	O2Request *o2request = [[O2Request alloc] init];
	return o2request;
}

- (void) post:(NSString *)method withData:(NSDictionary *)data {
	NSString *basicAuth;
	if (USE_BASIC_AUTH) {
		basicAuth = [NSString stringWithFormat:@"%@:%@@", APP_USERNAME, APP_PASSWORD];
	} else {
		basicAuth = [NSString stringWithFormat:@""];
	}
 
	NSString *strURL = [NSString stringWithFormat:@"%@://%@%@/%@", APP_PROTOCOL, basicAuth, APP_HOST, method];
	NSLog(@"%@", strURL);
	
	[url release];
	url = [[NSURL alloc] initWithString:strURL];
	NSString *postString = [self paramsToString:data];
	
	[self createRequest:@"POST" withParms:postString];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"O2RequestStart" object:self];
	
	[connection release];
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	if (!connection) [[NSNotificationCenter defaultCenter] postNotificationName:@"O2RequestConnectionError" object:self];
}

- (void) get:(NSString *)method withData:(NSDictionary *)data {
	NSString *basicAuth;
	if (USE_BASIC_AUTH) {
		basicAuth = [NSString stringWithFormat:@"%@:%@@", APP_USERNAME, APP_PASSWORD];
	} else {
		basicAuth = [NSString stringWithFormat:@""];
	}
	
	NSMutableString *paramString = (NSMutableString *)[self paramsToString:data];
	if ([paramString length] > 0) {
		[paramString insertString:@"?" atIndex:0];
	}
	NSString *strURL = [NSString stringWithFormat:@"%@://%@%@/%@%@", APP_PROTOCOL, basicAuth, APP_HOST, method, paramString];
	NSLog(@"%@", strURL);
	
	[url release];
	url = [[NSURL alloc] initWithString:strURL];
	
	[self createRequest:@"GET" withParms:paramString];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"O2RequestStart" object:self];
	
	[connection release];
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	if (!connection) [[NSNotificationCenter defaultCenter] postNotificationName:@"O2RequestConnectionError" object:self];
}

- (NSString *) paramsToString:(NSDictionary *)data {
	NSMutableString *paramStr = [NSMutableString stringWithFormat:@""];
	BOOL first = YES;
	for(NSString *key in data) {
		if (first == YES) {
			first = NO;
			[paramStr appendFormat:@"%@=%@", key, [data objectForKey:key]];
		} else {
			[paramStr appendFormat:@"&%@=%@", key, [data objectForKey:key]];
		}
	}
	NSLog(@"Params: %@", paramStr);
	return paramStr;
}

- (void) createRequest:(NSString *)type withParms:(NSString *)params {
	NSMutableURLRequest *_request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:CACHE_POLICY timeoutInterval:TIMEOUT_INTERVAL];
	NSString *paramsLength = [NSString stringWithFormat:@"%d", [params length]];
	[_request setHTTPMethod:type];
	[_request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	if (type == @"POST") {
		[_request setValue:paramsLength forHTTPHeaderField:@"Content-Length"];
		[_request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
	} else if (type == @"GET") {
		// Do nothing
	}
	self.request = _request;
	[_request release];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"O2RequestReceiveAuthenticationChallenge" object:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"O2RequestFailWithError" object:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	NSLog(@"Data received:");
	NSLog(@"%@", response);
	[receivedData appendData:data];
	[response release];
}

- (void) connectionDidFinishLoading: (NSURLConnection*) connection {
	NSString *response = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
	parsedData = [response JSONValue];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"O2RequestFinished" object:self];
	[response release];
}

- (NSDictionary *) data {
	return parsedData;
}

- (void)dealloc {
	[parsedData release];
	[receivedData release];
	[connection release];
	[request release];
	[url release];
    [super dealloc];
}

@end
