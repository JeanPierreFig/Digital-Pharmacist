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
    
    _zipCodes = [[NSMutableArray alloc] initWithObjects:@"00785",@"32828", nil];
    
    //Setup Tableview
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"AddSegue"]) {
        ZipCodeInputViewController *vc = [segue destinationViewController];
        vc.delegate = self;
    }
}

#pragma mark ZipCodeDelegate

- (void)didAddZipCode:(NSString *)code {
    [_zipCodes addObject:code];
    [_tableView reloadData];
}

#pragma mark UITableViewDelegate

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _zipCodes.count;
}

#pragma mark UITableViewDelegate

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cell_Id = @"zipCodeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_Id];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:cell_Id];
    }
    
    cell.textLabel.text = _zipCodes[indexPath.row];
    return cell;
}
@end
