//
//  User.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/9/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface User : NSObject {
    NSString *user_id;
    NSString *username;
    NSString *email;
    NSString *password;
    NSString *twitter_id;
    NSString *facebook_id;
    BOOL logged;
    BOOL drinking;
    NSDecimalNumber *beerId;
    NSString *beerName;
    NSDecimalNumber *placeId;
    NSString *placeName;
    NSString *placeAddress;
}

@property (nonatomic, retain) NSString *user_id;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *twitter_id;
@property (nonatomic, retain) NSString *facebook_id;
@property (nonatomic) BOOL logged;

@property (nonatomic) BOOL drinking;
@property (nonatomic, retain) NSDecimalNumber *beerId;
@property (nonatomic, retain) NSString *beerName;
@property (nonatomic, retain) NSDecimalNumber *placeId;
@property (nonatomic, retain) NSString *placeName;
@property (nonatomic, retain) NSString *placeAddress;

- (void) copy:(User *) user;
- (void) fill:(NSDictionary *) info;
- (void) setBeer:(NSDictionary *) info;
- (void) setPlace:(NSDictionary *) info;

@end
