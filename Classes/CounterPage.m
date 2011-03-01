//
//  CounterPage.m
//  BeerCounter
//
//  Created by Oscar De Moya on 2/21/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "CounterPage.h"

static NSArray *__pageControlColorList = nil;

@implementation CounterPage

@synthesize pageNumberLabel;

// Creates the color list the first time this method is invoked. Returns one color object from the list.
+ (UIColor *)pageControlColorWithIndex:(NSUInteger)index {
    if (__pageControlColorList == nil) {
        __pageControlColorList = [[NSArray alloc] initWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor magentaColor],
                                  [UIColor blueColor], [UIColor orangeColor], [UIColor brownColor], [UIColor grayColor], nil];
    }
	
    // Mod the index by the list length to ensure access remains in bounds.
    return [__pageControlColorList objectAtIndex:index % [__pageControlColorList count]];
}

// Load the view nib and initialize the pageNumber ivar.
- (id)initWithPageNumber:(int)page {
    if ((self = [super initWithNibName:@"CounterPage" bundle:nil])) {
        pageNumber = page;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    //[super viewDidLoad];
    pageNumberLabel.text = [NSString stringWithFormat:@"Pagina %d", pageNumber + 1];
    // Do any additional setup after loading the view from its nib.
}

- (void)dealloc
{
    [pageNumberLabel release];
    [super dealloc];
}

@end
