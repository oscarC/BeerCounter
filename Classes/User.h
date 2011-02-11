//
//  User.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/9/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface User : NSObject {

}

@property (nonatomic, retain) NSString *user_id;
@property (nonatomic, retain) NSString *nickname;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *twitter_id;
@property (nonatomic, retain) NSString *facebook_id;

@end
