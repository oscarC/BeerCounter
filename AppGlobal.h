//
//  AppGlobal.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/16/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

typedef enum {
    BEER_COUNTER_SIGNUP = 0,
	FACEBOOK_CONNECT,
    TWITTER_CONNECT,
} SignUpMode;

extern SignUpMode gSignUpMode;

