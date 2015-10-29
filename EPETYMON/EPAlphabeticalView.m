//
//  EPAlphabeticalView.m
//  EPETYMON
//
//  Created by Kostas Terzidis on 3/21/13.
//  Copyright (c) 2013 Kostas Terzidis. All rights reserved.
//

#import "EPAlphabeticalView.h"
#import "EPDefinitionView.h"

@interface EPAlphabeticalView ()

@end

@implementation EPAlphabeticalView

@synthesize letters;
@synthesize letterLookup;
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    appDelegate = [[UIApplication sharedApplication] delegate];
    words = appDelegate.words;
   // NSLog(@"words count = %d",[words count]);
    [self setupLetters];
    [self setupLetterLookup];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table view methods

- (void) setupLetterLookup {
    NSMutableDictionary *lu = [[NSMutableDictionary alloc] initWithCapacity:26];
    for (int idx=0; idx < [words count]; idx++) {
        NSString *word = (NSString *)[words objectAtIndex:idx];
        NSString *letter = [word substringWithRange:(NSRange){0,1}];
        NSMutableArray *letterArray = [lu objectForKey:letter];
        if (letterArray == nil) {
            letterArray = [[NSMutableArray alloc] init];
            [lu setObject:letterArray forKey:letter];
        }
        [letterArray addObject:word];
    }
    self.letterLookup = lu;
}

- (void) setupLetters {
    NSString *chars = @"αβγδεζηθικλμνξοπρστυφχψω";
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int idx=0; idx < [chars length]; idx++) {
        unichar character = [chars characterAtIndex:idx];
        NSString *letter = [NSString stringWithCharacters:&character length:1];
        [array addObject:letter];
    }
    self.letters = array;
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return index;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return letters;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [letters count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = [letters objectAtIndex:section];
    NSArray *luLetters = (NSArray *)[letterLookup objectForKey:key];
    unsigned long numberOfRows = [luLetters count];
    //NSLog(@"There are %f rows in the section for %@", numberOfRows, key);
    return numberOfRows;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"DefinitionName";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero ];
    }
    
    // Set up the cell...
    cell.textLabel.text = [self wordForIndexPath:indexPath];
    
    // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (NSString *) wordForIndexPath:(NSIndexPath *)indexPath {
    return [(NSArray *)[letterLookup objectForKey:[letters objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *word = [self wordForIndexPath:indexPath];
    NSString *definition = [appDelegate definitionForWord:word];
    
    //MOVE TO THE NEXT VIEW
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    EPDefinitionView* controller = [sb instantiateViewControllerWithIdentifier:@"Definition"];
    controller.word = word;
    controller.definition = definition;
    [self.navigationController pushViewController:controller animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [letters objectAtIndex:section];
}

@end
