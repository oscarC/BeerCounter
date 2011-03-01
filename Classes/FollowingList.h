//
//  FriendList.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/21/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class O2Request;

@interface FollowingList : UITableViewController {
    O2Request *request;
    NSArray *dataArray;
}

@property (nonatomic, retain) NSArray *dataArray;

- (void) showAlert:(NSString *)errorMsg withTitle:(NSString *)title;
- (void) friendList;
- (void) friendListResponse;
- (void) followFriend:(NSString *)username;
- (void) followFriendResponse;

@end
