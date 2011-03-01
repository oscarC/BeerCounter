//
//  StartDrinking.m
//  BeerCounter
//
//  Created by Oscar De Moya on 2/21/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import "StartDrinking.h"
#import "BeerCounterAppDelegate.h"
#import "O2Request.h"
#import "O2Navigation.h"
#import "O2FormHelper.h"
#import "PlaceList.h"
#import "DrinkList.h"
#import "User.h"


@implementation StartDrinking

- (void) startDrinking {
    BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSMutableDictionary *data = [NSMutableDictionary dictionary];
    User *user = beerCounterDelegate.auth.user;
	[data setObject:user.user_id forKey:@"user_id"];
    [data setObject:user.beerId forKey:@"drink_id"];
    [data setObject:user.placeId forKey:@"location_id"];
    [data setObject:user.placeName forKey:@"location"];
    [data setObject:user.placeAddress forKey:@"address"];
	[request post:@"Drink/start" withData:data];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startDrinkingResponse) name:@"O2RequestFinished" object:request];
}

- (void) startDrinkingResponse {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"O2RequestFinished" object:request];
	NSDictionary *data = [request data];
	NSLog(@"%@", data);
    BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
    beerCounterDelegate.auth.user.drinking = YES;
    [beerCounterDelegate.auth.navigation updateDashboard];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(startDrinking)];
    request = [O2Request request];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
	self.title = @"Start Drinking";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"CellStartDrinking";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
    BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
    User *user = beerCounterDelegate.auth.user;
	if ([indexPath section] == 0) {
		if ([indexPath row] == 0) {
			cell.textLabel.text = @"What?";
            if(user.beerId == 0) {
                cell.detailTextLabel.text = @"(required)";
            } else {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", user.beerName];
            }
		} else {
			cell.textLabel.text = @"Where?";
            if(user.placeId == 0) {
                cell.detailTextLabel.text = @"(optional)";
            } else {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", user.placeName];
            }
		}
	}
	return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BeerCounterAppDelegate *beerCounterDelegate = (BeerCounterAppDelegate *)[[UIApplication sharedApplication] delegate];
    O2Navigation *nav = beerCounterDelegate.auth.navigation;
    
    NSInteger row = [indexPath row];
    if(row == 0) {
        [nav gotoDrinkList];
    } else if(row == 1) {
        [nav gotoPlaceList];
    }
}

@end
