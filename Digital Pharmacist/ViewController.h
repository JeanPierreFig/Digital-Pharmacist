//
//  ViewController.h
//  Digital Pharmacist
//
//  Created by Jean Pierre on 8/28/18.
//  Copyright © 2018 Jean Pierre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *zipCodes;

@end

