//
//  EPDefinitionView.m
//  EPETYMON
//
//  Created by Kostas Terzidis on 3/21/13.
//  Copyright (c) 2013 Kostas Terzidis. All rights reserved.
//

#import "EPDefinitionView.h"
#import "EPAboutView.h"

@interface EPDefinitionView ()

@end

@implementation EPDefinitionView

@synthesize word;
@synthesize definition;
@synthesize appDelegate;


- (void)viewDidLoad
{
    self.navigationItem.title = word;
    nameLabel.text = word;
    definitionView.text = definition;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UITapGestureRecognizer *taprecog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    taprecog.numberOfTapsRequired = 2;
    taprecog.numberOfTouchesRequired = 1;
    [definitionView addGestureRecognizer:taprecog];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSString *) escapeForMailto:(NSString *)string {
    return (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,  (CFStringRef)string, NULL,  CFSTR("?=&+"), kCFStringEncodingUTF8));
}



- (IBAction)aboutAction:(id)sender {
        
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    EPAboutView* controller = [sb instantiateViewControllerWithIdentifier:@"About"];
    [self.navigationController pushViewController:controller animated:YES];
    
}


- (IBAction)emailDefinition:(id)sender {
    
    NSLog(@"Emailing definition for %@", word);
    
    NSString *subject = [self escapeForMailto:[NSString stringWithFormat:@"Etymological Definition: %@", word]];
    NSString *body = [self escapeForMailto:[NSString stringWithFormat:@"Σοῦ παραθέτω ἕναν ὁρισμό άπό τό Λεξικό τοῦ Βασδέκη:\n\n%@\n\n%@", word, definition]];
    
    NSString *mailto = [NSString stringWithFormat:@"mailto:?subject=%@&body=%@", subject, body];
    //    NSString *mailto = @"mailto:?subject=";
    NSURL *url = [NSURL URLWithString:mailto];
    if (![[UIApplication sharedApplication] openURL:url]) {
        NSLog(@"Could not open the url %@", mailto);
    }

    
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gesture {
    
    CGPoint pos = [gesture locationInView:self.view];
    
    //NSLog(@"Tap Gesture Coordinates: %.2f %.2f", pos.x, pos.y);
    
    //eliminate scroll offset
    pos.y += definitionView.contentOffset.y;
    pos.y -= 69;  //eliminate header
    
    //get location in text from textposition at point
    UITextPosition *tapPos = [definitionView closestPositionToPoint:pos];
    
    //fetch the word at this position (or nil, if not available)
    UITextRange * wr = [definitionView.tokenizer rangeEnclosingPosition:tapPos withGranularity:UITextGranularityWord inDirection:UITextLayoutDirectionRight];
    
    //NSLog(@"WORD: %@", [definitionView textInRange:wr]);
    //MOVE TO THE NEXT VIEW
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    EPDefinitionView* controller = [sb instantiateViewControllerWithIdentifier:@"Definition"];
    appDelegate = [[UIApplication sharedApplication] delegate];
    controller.word = [definitionView textInRange:wr];
    controller.definition = [appDelegate definitionForWord:controller.word];
    [self.navigationController pushViewController:controller animated:YES];
    
}



@end
