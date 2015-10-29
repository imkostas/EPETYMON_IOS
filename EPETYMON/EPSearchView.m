//
//  EPSearchView.m
//  EPETYMON
//
//  Created by Kostas Terzidis on 3/21/13.
//  Copyright (c) 2013 Kostas Terzidis. All rights reserved.
//

#import "EPSearchView.h"
#import "EPDefinitionView.h"

@interface EPSearchView ()

@end

@implementation EPSearchView

@synthesize appDelegate;
@synthesize searchBar;
@synthesize words;


- (void)viewDidLoad
{
    appDelegate = [[UIApplication sharedApplication] delegate];
    self.words = [appDelegate words];
    [searchBar setDelegate:self];
    [searchBar becomeFirstResponder];
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) reset {
    NSLog(@"Resetting");
    appDelegate = [[UIApplication sharedApplication] delegate];
    self.words = [appDelegate words];
    [self.tableView reloadData];
}

- (void) search {
    //NSLog(@"Searching with text: %@", searchBar.text);
    NSMutableArray *newWords = [[NSMutableArray alloc] init];
    appDelegate = [[UIApplication sharedApplication] delegate];
    NSEnumerator *enumerator = [[appDelegate words] objectEnumerator];
    NSString *word;
    while ((word = (NSString *)[enumerator nextObject]) != nil) {
        NSRange range = [word rangeOfString:searchBar.text options:NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch];
        if (range.location != NSNotFound) {
            [newWords addObject:word];
        }
    }
    
    //NSLog(@"Found %d searched words", [newWords count]);
    self.words = newWords;
    [self.tableView reloadData];
}


// search methods

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)aSearchBar {
    //NSLog(@"Search bar should end editing");
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)aSearchBar {
    //NSLog(@"Search bar text did end editing");
    
}

- (void)searchBar:(UISearchBar *)aSearchBar textDidChange:(NSString *)searchText {
    //NSLog(@"Search bar text changed");
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)aSearchBar {
    //NSLog(@"Search bar cancel clicked");
    [aSearchBar resignFirstResponder];
    [self reset];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)aSearchBar {
    [aSearchBar resignFirstResponder];
    //NSLog(@"Search button clicked");
    [self search];
}

// table view methods

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


- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"SearchName";
    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    }
    
    // Set up the cell...
    cell.textLabel.text = [words objectAtIndex:indexPath.row];
    // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [words count];
}
@end
