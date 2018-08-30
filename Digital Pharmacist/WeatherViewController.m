//
//  WeatherViewController.m
//  Digital Pharmacist
//
//  Created by Jean Pierre on 8/29/18.
//  Copyright © 2018 Jean Pierre. All rights reserved.
//

#import "WeatherViewController.h"

@interface WeatherViewController ()

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getWeather];
    [_location setText:@""];
    [_temperature setText:@""];
    [_summary setText:@""];
}

- (void)getWeather {
    NSString *dataUrl = [NSString stringWithFormat:@"https://api.darksky.net/forecast/bcdc45837d94ebb5f7822c0526f05b14/%@,%@",_zipCodeData[@"lat"], _zipCodeData[@"lng"]];
    NSURL *url = [NSURL URLWithString:dataUrl];
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
    dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
          
          NSError *jsonError;
          NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
          if (jsonError) {
              NSLog(@"%@", jsonError.localizedDescription);
              return;
          }
          if (dict[@"currently"]) {
              NSDictionary *currently = dict[@"currently"];
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self displayWeather:currently];
                  [self setDataSource:dict];
              });
          }
      }];
    
    [downloadTask resume];
}

-(void)setDataSource:(NSDictionary *)data {
    //set weather data as the data source for the collectionView and tableView;
    _data = data;
    [_collectionView reloadData];
}

- (NSString *)convertUnix:(NSString *)unix {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[unix integerValue]];
    NSDateFormatter * formatter=[[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [formatter setDateFormat:@"dd/MM/yyyy hh:mma"];
    [formatter setDateFormat:@"hh:mma"];
    return [formatter stringFromDate:date];
}

- (IBAction)dissmissViewController:(id)sender {
    [self.view.window.rootViewController dismissViewControllerAnimated:true completion:nil];
}

- (void)displayWeather:(NSDictionary *)currently {
    [_activityIndicator stopAnimating];
    [_iconImageView setImage:[UIImage imageNamed:currently[@"icon"]]];
    [_location setText:_zipCodeData[@"location"]];
    [_summary setText:currently[@"summary"]];
    [_temperature setText:[NSString stringWithFormat:@"%li°",[currently[@"apparentTemperature"] integerValue]]];
}

#pragma mark UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_data[@"hourly"][@"data"] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"weatherHourCell";
    WeatherCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell.iconImageView setImage:[UIImage imageNamed:_data[@"hourly"][@"data"][indexPath.row][@"icon"]]];
    [cell.temperature setText:[NSString stringWithFormat:@"%li°",[_data[@"hourly"][@"data"][indexPath.row][@"apparentTemperature"] integerValue]]];
    [cell.time setText:[self convertUnix:_data[@"hourly"][@"data"][indexPath.row][@"time"]]];

    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
