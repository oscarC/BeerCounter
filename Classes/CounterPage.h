//
//  CounterPage.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/21/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CounterPage : UIViewController {
	UILabel *pageNumberLabel;
    int pageNumber;
}

@property (nonatomic, retain) IBOutlet UILabel *pageNumberLabel;

- (id)initWithPageNumber:(int)page;

@end
