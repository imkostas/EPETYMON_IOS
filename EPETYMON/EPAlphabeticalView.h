//
//  EPAlphabeticalView.h
//  EPETYMON
//
//  Created by Kostas Terzidis on 3/21/13.
//  Copyright (c) 2013 Kostas Terzidis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPAppDelegate.h"

@interface EPAlphabeticalView : UITableViewController{
    EPAppDelegate *appDelegate;
    NSArray *words;
    NSArray *letters;
    NSDictionary *letterLookup;
}

@property (nonatomic, retain) NSArray *letters;
@property (nonatomic, retain) NSDictionary *letterLookup;

@property (nonatomic, retain) EPAppDelegate *appDelegate;

- (void) setupLetters;
- (void) setupLetterLookup;
- (NSString *) wordForIndexPath:(NSIndexPath *)indexPath;

@end
