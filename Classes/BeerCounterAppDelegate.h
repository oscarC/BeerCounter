//
//  BeerCounterAppDelegate.h
//  BeerCounter
//
//  Created by Oscar De Moya on 2/8/11.
//  Copyright 2011 Koombea Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Welcome.h"
#import "User.h"

@interface BeerCounterAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	IBOutlet UINavigationController *navController;
	IBOutlet UITabBarController *tabBar;
    IBOutlet Welcome *welcome;
    User *user;
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBar;
@property (nonatomic, retain) IBOutlet Welcome *welcome;
@property (nonatomic, retain) User *user;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url;
- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;

@end

