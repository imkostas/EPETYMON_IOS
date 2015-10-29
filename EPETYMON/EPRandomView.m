//
//  EPRandomView.m
//  EPETYMON
//
//  Created by Kostas Terzidis on 3/21/13.
//  Copyright (c) 2013 Kostas Terzidis. All rights reserved.
//

#import "EPRandomView.h"
#import "EPDefinitionView.h"

@interface EPRandomView ()

@end

@implementation EPRandomView

@synthesize appDelegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = [[UIApplication sharedApplication] delegate];
    //NSLog(@"App delegate has %d words", [appDelegate.words count]);
    
    NSMutableArray *sortedWords = [NSMutableArray arrayWithArray:appDelegate.words] ;
    long length = [sortedWords count];
    for (int idx=0; idx < length; idx++) {
        long randIdx = random();
        randIdx = randIdx % length;
        [sortedWords exchangeObjectAtIndex:idx withObjectAtIndex:randIdx];
    }
    words = sortedWords;
    sortedWords = nil;
    //NSLog(@"Random view controller has %d words", [words count]);
}

-(void)viewWillAppear:(BOOL)animated{
    
    NSMutableArray *sortedWords = [NSMutableArray arrayWithArray:appDelegate.words] ;
    long length = [sortedWords count];
    for (int idx=0; idx < length; idx++) {
        unsigned int randIdx = arc4random();
        randIdx = randIdx % length;
        [sortedWords exchangeObjectAtIndex:idx withObjectAtIndex:randIdx];
    }
    words = sortedWords;
    sortedWords = nil;
    //NSLog(@"Random view controller has %d words", [words count]);
    [self.tableView reloadData];
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [words count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"DefinitionName";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    }
    
    NSString *name = (NSString *)[words objectAtIndex:indexPath.row];
    
    // Set up the cell...
    cell.textLabel.text = name;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *word = [words objectAtIndex:indexPath.row];
    NSString *definition = [appDelegate definitionForWord:word];

    //MOVE TO THE NEXT VIEW
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    EPDefinitionView* controller = [sb instantiateViewControllerWithIdentifier:@"Definition"];
    controller.word = word;
    controller.definition = definition;
    [self.navigationController pushViewController:controller animated:YES];
 
}

@end
