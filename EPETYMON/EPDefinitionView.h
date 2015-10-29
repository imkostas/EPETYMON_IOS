//
//  EPDefinitionView.h
//  EPETYMON
//
//  Created by Kostas Terzidis on 3/21/13.
//  Copyright (c) 2013 Kostas Terzidis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPAppDelegate.h"

@interface EPDefinitionView : UIViewController <UIGestureRecognizerDelegate>{
    IBOutlet UILabel *nameLabel;
    IBOutlet UITextView *definitionView;
    NSString *word;
    NSString *definition;
    
    EPAppDelegate *appDelegate;
}

@property (nonatomic, retain) NSString *word;
@property (nonatomic, retain) NSString *definition;

@property (nonatomic, retain) EPAppDelegate *appDelegate;

- (IBAction)emailDefinition:(id)sender;
- (IBAction)aboutAction:(id)sender;
- (NSString *) escapeForMailto:(NSString *)string;
@end
