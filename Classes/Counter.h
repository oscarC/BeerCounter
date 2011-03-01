//
//  Counter.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/14/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class O2Request;

@interface Counter : UIViewController<UIScrollViewDelegate> {
    O2Request *request;
    UIScrollView *scrollView;
	UIPageControl *pageControl;
    NSMutableArray *viewControllers;
    BOOL pageControlUsed;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *viewControllers;

- (IBAction) changePage:(id)sender;
- (void) loadScrollViewWithPage:(int)page;
- (void) stopDrinking;
- (void) stopDrinkingResponse;

@end
