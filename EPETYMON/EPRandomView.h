//
//  EPRandomView.h
//  EPETYMON
//
//  Created by Kostas Terzidis on 3/21/13.
//  Copyright (c) 2013 Kostas Terzidis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPAppDelegate.h"

@interface EPRandomView : UITableViewController{
    NSArray *words;
    EPAppDelegate *appDelegate;
}

@property (nonatomic, retain) EPAppDelegate *appDelegate;

@end
