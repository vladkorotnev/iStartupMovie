//
//  MainViewController.m
//  bootsoundmanager
//
//  Created by Vladislav on 27.07.11.
//  Copyright 2011 Tigr@Soft. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)showInfo:(id)sender
{    
     NSFileManager *fm = [NSFileManager defaultManager];
    system("rm -rf /var/mobile/startup.mov");
    if (sender != self) {
        if (![fm fileExistsAtPath:@"/var/mobile/startup.mov"]) {
            UIAlertView *success = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Successfully uninstalled movie" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [success show];
            [success release];
        } 
    }

    [tableVw reloadData];
}

- (IBAction)about:(id)sender {

    UIAlertView *info = [[UIAlertView alloc]initWithTitle:@"iStartupMovie Manager v1.0" message:@"For iStartupMovie 1.0 and higher.\n\n © Vladislav Korotnev, 2011\nWebsite:\nhttp://vladkorotnev.github.com\n\nTwitter: @vladkorotnev" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [info show];
    [info release];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations.
    return YES;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    [super dealloc];
}

//---------------------------------
// Table
//---------------------------------

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *sets = [fm contentsOfDirectoryAtPath:@"/var/mobile/Library/StartupMovies" error:nil];
    // Return the number of rows in the section.
    return ([sets count]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    NSFileManager *fm = [NSFileManager defaultManager];

    NSArray *sets = [fm contentsOfDirectoryAtPath:@"/var/mobile/Library/StartupMovies" error:nil];
        [cell.textLabel setText:[sets objectAtIndex:(indexPath.row)]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
             NSFileManager *fm = [NSFileManager defaultManager];
    NSLog(@"%d",indexPath.row);
        NSString *src = [NSString stringWithFormat:@"/var/mobile/Library/StartupMovies/%@",[tableVw cellForRowAtIndexPath:indexPath].textLabel.text];
        NSLog(@"installing");
        [self showInfo:self];
        [fm copyItemAtPath:src toPath:@"/var/mobile/startup.mov" error:nil];
        if ([fm fileExistsAtPath:@"/var/mobile/startup.mov"]) {
            UIAlertView *success = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Successfully installed movie" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [success show];
            [success release];
            [tableVw deselectRowAtIndexPath:indexPath animated:true];
        }
    [tableVw reloadData];
}


@end
