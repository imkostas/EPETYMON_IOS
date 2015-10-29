//
//  EPSearchView.h
//  EPETYMON
//
//  Created by Kostas Terzidis on 3/21/13.
//  Copyright (c) 2013 Kostas Terzidis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPAppDelegate.h"

@interface EPSearchView : UITableViewController <UISearchBarDelegate>{
    EPAppDelegate *appDelegate;
    IBOutlet UISearchBar *searchBar;
    NSArray *words;
}
@property (strong, nonatomic) UISearchBar *searchBar;
@property (nonatomic, retain) EPAppDelegate *appDelegate;
@property (nonatomic, retain) NSArray *words;

- (void) search;
- (void) reset;

@end
