//
//  User.m
//  BeerCounter
//
//  Created by Oscar De Moya on 2/9/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "User.h"


@implementation User

@synthesize user_id, username, email, password, twitter_id, facebook_id, logged;
@synthesize drinking, beerId, beerName, placeId, placeName, placeAddress;

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

- (void) fill:(NSDictionary *) info {
    self.user_id = [info  objectForKey:@"id"];
    self.email = [info  objectForKey:@"email"];
    self.password = [info  objectForKey:@"password"];
    self.username = [info  objectForKey:@"username"];
    self.twitter_id = [info objectForKey:@"twitter_id"];
    self.facebook_id = [info objectForKey:@"facebook_id"];
    BOOL _drinking = FALSE;
    if((NSNull *)[info objectForKey:@"drinking"] != [NSNull null]) {
        NSObject *obj = [info objectForKey:@"drinking"];
        if([obj isKindOfClass:[NSString class]]) {
            if([(NSString *)obj isEqualToString:@"true"]) {
                _drinking = TRUE;
            }
        } else if([[NSString stringWithFormat:@"%@", obj] isEqualToString:@"1"]) {
            _drinking = TRUE;
        }
    }
    self.drinking = _drinking;
    if(self.drinking) NSLog(@"is drinking");
}

- (void) setBeer:(NSDictionary *) info {
    self.beerId = [info objectForKey:@"id"];
    self.beerName = [info objectForKey:@"name"];
}

- (void) setPlace:(NSDictionary *) info {
    self.placeId = [info objectForKey:@"id"];
    self.placeName = [info objectForKey:@"name"];
    self.placeAddress = [info objectForKey:@"address"];
}
    
@end
