//
//  DrinkListTableViewController.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/11/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class O2Request;

@interface DrinkList : UITableViewController {
	O2Request *request;
	NSArray *dataArray;
}

@property (nonatomic, retain) NSArray *dataArray;

- (void) drinkList;
- (void) drinkListResponse;

@end
