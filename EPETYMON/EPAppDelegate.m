//
//  EPAppDelegate.m
//  EPETYMON
//
//  Created by Kostas Terzidis on 3/19/13.
//  Copyright (c) 2013 Kostas Terzidis. All rights reserved.
//

#import "EPAppDelegate.h"
#import <sqlite3.h>

@implementation EPAppDelegate

@synthesize words;
@synthesize query;
@synthesize definition;
@synthesize name;

NSString *DATABASE_FILE_NAME=@"words.db";
NSString *DATABASE_RESOURCE_PATH=@"words";
NSString *DATABASE_RESOURCE_TYPE=@"db";

- (void) initializeDatabase {
    NSLog(@"Initializing database");
    NSString *resourceDbPath = [[NSBundle mainBundle] pathForResource:DATABASE_RESOURCE_PATH ofType:DATABASE_RESOURCE_TYPE];
    dbFilePath = resourceDbPath;

}

- (NSString *)definitionForWord:(NSString *)word {
    sqlite3 *db;
    int dbrc;
    dbrc = sqlite3_open([dbFilePath UTF8String], &db);
    if (dbrc) {
        NSLog(@"Could not open database: %d", dbrc);
        return nil;
    }
    NSLog(@"Database opened successfully");
    
    sqlite3_stmt *dbps;
    query = [[NSString alloc] initWithFormat:@"select definition from words where name = '%@'", word];
    dbrc = sqlite3_prepare_v2(db, [query UTF8String], -1, &dbps, NULL);
    definition = nil;
    if ((dbrc = sqlite3_step(dbps)) == SQLITE_ROW) {
        definition = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(dbps, 0)] ;
    }
    
    sqlite3_finalize(dbps);
    sqlite3_close(db);
    return definition;
}

- (void) loadWords {
    NSLog(@"Loading words from %@", dbFilePath);
    NSMutableArray *loadedWords = [[NSMutableArray alloc] initWithCapacity:1000];
    sqlite3 *db;
    int dbrc;
    dbrc = sqlite3_open([dbFilePath UTF8String], &db);
    if (dbrc) {
        NSLog(@"Could not open database: %d", dbrc);
        return;
    }
    //NSLog(@"Database opened successfully");
    
    sqlite3_stmt *dbps;
    query = [[NSString alloc] initWithFormat:@"select name from words order by name"];
    dbrc = sqlite3_prepare_v2(db, [query UTF8String], -1, &dbps, NULL);
    while ((dbrc = sqlite3_step(dbps)) == SQLITE_ROW) {
        name = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(dbps, 0)];
        [loadedWords addObject:name];
    }
    
    sqlite3_finalize(dbps);
    sqlite3_close(db);
    words = loadedWords;
    
    //NSLog(@"Loaded %d words", [words count]);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [self initializeDatabase];
    [self loadWords];    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self setWords:nil];
    [self setQuery:nil];
    [self setDefinition:nil];
    [self setName:nil];
}

@end
