//
//  FriendsFeed.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/14/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class O2Request;

@interface FriendFeeds : UITableViewController {
    O2Request *request;
	NSArray *arrayFeeds;
}

@property (nonatomic, retain) O2Request *request;
@property (nonatomic, retain) NSArray *arrayFeeds;

- (void) friendFeeds;
- (void) friendFeedsResponse;

@end
