//
//  ViewController.m
//  Digital Pharmacist
//
//  Created by Jean Pierre on 8/28/18.
//  Copyright © 2018 Jean Pierre. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"zipCodes"] == nil) {
        NSLog(@"hello");
        _zipCodes = [[NSMutableArray alloc] initWithObjects:@{@"zipCode":@"32828",@"lat":@"28.529058",@"lng":@"-81.166348",@"location":@"Orlando, FL"},
                     @{@"zipCode":@"78710",@"lat":@"30.260023",@"lng":@"-97.739727",@"location":@"Austin, TX"},
                     @{@"zipCode":@"10001",@"lat":@"40.75065",@"lng":@"-73.99692400000001",@"location":@"New York, NY"},nil];
    }
    else {
        _zipCodes = [[defaults objectForKey:@"zipCodes"] mutableCopy];
    }
    
    //Setup Tableview
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void)saveDataSource {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_zipCodes forKey:@"zipCodes"];
    [defaults synchronize];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"AddSegue"]) {
        ZipCodeInputViewController *destination = [segue destinationViewController];
        destination.delegate = self;
    }
    if ([[segue identifier] isEqualToString:@"Detail"]) {
        WeatherViewController *destination = [segue destinationViewController];
        destination.zipCodeData = _zipCodes[[_tableView indexPathForSelectedRow].row];
    }
}

- (IBAction)editButtonTapped:(UIBarButtonItem *)sender {
    [_tableView setEditing:![_tableView isEditing]];
    [sender setTitle:[_tableView isEditing] ? @"Done" : @"Edit"];
}


#pragma mark ZipCodeDelegate

- (void)didAddZipCode:(NSDictionary *)zipCodeData {
    NSLog(@"%@", zipCodeData);
    [_zipCodes addObject:zipCodeData];
    [self saveDataSource];
    [_tableView reloadData];
}

#pragma mark UITableViewDelegate

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _zipCodes.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cell_Id = @"zipCodeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_Id];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:cell_Id];
    }
    
    cell.textLabel.text = _zipCodes[indexPath.row][@"zipCode"];
    cell.detailTextLabel.text = _zipCodes[indexPath.row][@"location"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"Detail" sender:nil];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.zipCodes removeObjectAtIndex:indexPath.row];
        [self saveDataSource];
        
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
        [self.tableView endUpdates];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
@end
