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
	o2request.receivedData = [[NSMutableData alloc] init];
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

- (void) _post:(NSString *)toURL withData:(NSDictionary *)data {
	NSLog(@"%@", toURL);
	
	[url release];
	url = [[NSURL alloc] initWithString:toURL];
	NSString *postString = [self paramsToString:data];
	
	[self createRequest:@"POST" withParms:postString];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"O2RequestStart" object:self];
	
	[connection release];
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	if (!connection) [[NSNotificationCenter defaultCenter] postNotificationName:@"O2RequestConnectionError" object:self];
}

- (void) _get:(NSString *)toURL withData:(NSDictionary *)data {	
	NSMutableString *paramString = (NSMutableString *)[self paramsToString:data];
	if ([paramString length] > 0) {
		[paramString insertString:@"?" atIndex:0];
	}
	NSString *strURL = [NSString stringWithFormat:@"%@%@", toURL, paramString];
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
	[receivedData appendData:data];
}

- (void) connectionDidFinishLoading: (NSURLConnection*) connection {
	NSString *response = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", response);
	@try {
        parsedData = [response JSONValue];
    }
    @catch (NSException *exception) {
        NSLog(@"Error Parsing JSON Response:\n%@", response);
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"O2RequestFinished" object:self];
    [response release];
}

- (id) data {
	return parsedData;
}

- (NSString *) extractValueFromParamString:(NSString *)strParams withKey:(NSString *)strKey {
	if (!strParams) return nil;
	
	NSArray	*tuples = [strParams componentsSeparatedByString: @"&"];
	if (tuples.count < 1) return nil;
	
	for (NSString *tuple in tuples) {
		NSArray *keyValueArray = [tuple componentsSeparatedByString: @"="];
		
		if (keyValueArray.count == 2) {
			NSString *key = [keyValueArray objectAtIndex: 0];
			NSString *value = [keyValueArray objectAtIndex: 1];
			if ([key isEqualToString:strKey]) return value;
		}
	}
	return nil;
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
