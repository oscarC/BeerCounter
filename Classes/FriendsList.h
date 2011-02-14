//
//  FriendsList.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/14/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class O2Request;

@interface FriendsList : UITableViewController {
    O2Request *request;
	NSArray *usersArray;
@private
    
}

@property (nonatomic, retain) NSArray *usersArray;

- (void) userList;
- (void) userListResponse;

@end
