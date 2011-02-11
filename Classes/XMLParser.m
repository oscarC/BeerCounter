//
//  XMLParser.m
//  FoursquareList
//
//  Created by Oscar De Moya on 2/4/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "XMLParser.h"
#import "User.h"

static NSSet *interestingKeys;

@implementation XMLParser

+ (void)initialize
{
    if (!interestingKeys) {
        interestingKeys = [[NSSet alloc] initWithObjects:@"id", @"nickname", @"email", @"twitter_id", @"facebook_id", nil];
    }
}

- (void)dealloc
{
    [items release];
    [super dealloc];
}

- (BOOL)parseData:(NSData *)d
{
    // Release the old itemArray
    [items release];
	
    // Create a new, empty itemArray
    items = [[NSMutableArray alloc] init];
	
    // Create a parser
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:d];
    [parser setDelegate:self];
	
    // Do the parse
    [parser parse];
	
    [parser release];
	
    NSLog(@"items = %@", items);
    return YES;
}

- (NSArray *)items
{
	//NSLog([NSString stringWithFormat:@"%d", items.count]);
    return items;
}

#pragma mark Delegate calls

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName
attributes:(NSDictionary *)attributeDict 
{
    //NSLog(@"Starting Element: %@", elementName);
	
    // Is it the start of a new item?
    if ([elementName isEqual:@"user"]) {
		
        // Create a dictionary for the title/url for the item
        entityInProgress = [[User alloc] init];
        return;
    }
	
    // Is it the title/url for the current item?
    if ([interestingKeys containsObject:elementName]) {
        keyInProgress = [elementName copy];
    }
}

- (void)parser:(NSXMLParser *)parser
didEndElement:(NSString *)elementName
namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName
{
    //NSLog(@"Ending Element: %@", elementName);
	
    // Is the current item complete?
    if ([elementName isEqual:@"user"]) {
		[items addObject:entityInProgress];
		
        // Clear the current item
        [entityInProgress release];
        entityInProgress = nil;
        return;
    }
	
    // Is the current key complete?
    if ([elementName isEqual:keyInProgress]) {
		//NSLog(@"Text: %@", textInProgress);
        if ([elementName isEqual:@"id"]) {
            [entityInProgress setUser_id:textInProgress];
        } else if ([elementName isEqual:@"nickname"]) {
            [entityInProgress setNickname:textInProgress];
        } else if ([elementName isEqual:@"email"]) {
			[entityInProgress setEmail:textInProgress];
        } else if ([elementName isEqual:@"twitter_id"]) {
			[entityInProgress setTwitter_id:textInProgress];
        } else if ([elementName isEqual:@"facebook_id"]) {
			[entityInProgress setFacebook_id:textInProgress];
		}
		
        // Clear the text and key
        [textInProgress release];
        textInProgress = nil;
        [keyInProgress release];
        keyInProgress = nil;
    }
}

// This method can get called multiple times for the
// text in a single element
- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string
{
	textInProgress = [string copy];
}

@end