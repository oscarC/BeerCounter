//
//  User.m
//  BeerCounter
//
//  Created by Oscar De Moya on 2/9/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "User.h"


@implementation User

@synthesize user_id, username, email, password, twitter_id, facebook_id, drinking;
@synthesize logged;

- (void) copy:(User *) user {
    self.user_id = user.user_id;
    self.email = user.email;
    self.password = user.password;
    self.username = user.username;
    self.twitter_id = user.twitter_id;
    self.facebook_id = user.facebook_id;
    self.drinking = user.drinking;
    self.logged = user.logged;
}

- (void) fill:(NSDictionary *) userinfo {
    self.user_id = [userinfo  objectForKey:@"id"];
    self.email = [userinfo  objectForKey:@"email"];
    self.password = [userinfo  objectForKey:@"password"];
    self.username = [userinfo  objectForKey:@"username"];
    self.twitter_id = [userinfo objectForKey:@"twitter_id"];
    self.facebook_id = [userinfo objectForKey:@"facebook_id"];
    BOOL _drinking = FALSE;
    if((NSNull *)[userinfo objectForKey:@"drinking"] != [NSNull null]) {
        NSObject *obj = [userinfo objectForKey:@"drinking"];
        if([obj isKindOfClass:[NSString class]]) {
            if([(NSString *)obj isEqualToString:@"true"]) {
                _drinking = TRUE;
            }
        } else if([[NSString stringWithFormat:@"%@", obj] isEqualToString:@"1"]) {
            _drinking = TRUE;
        }
    }
    self.drinking = _drinking;
}

@end
