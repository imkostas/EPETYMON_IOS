//
//  EPAppDelegate.h
//  EPETYMON
//
//  Created by Kostas Terzidis on 3/19/13.
//  Copyright (c) 2013 Kostas Terzidis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPAppDelegate : UIResponder <UIApplicationDelegate>{
    NSString *dbFilePath;
    NSArray *words;
    
    NSString *definition;
    NSString *query;
    NSString *name;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) NSArray *words;

@property (strong, nonatomic) NSString *definition;
@property (strong, nonatomic) NSString *query;
@property (strong, nonatomic) NSString *name;

- (void) initializeDatabase;
- (void) loadWords;
- (NSString *)definitionForWord:(NSString *)word;


@end
