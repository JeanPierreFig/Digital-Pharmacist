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
                  NSLog(@"%@", currently);
                  [self displayWeather:currently];
              });
          }
      }];
    
    [downloadTask resume];
}

- (void)displayWeather:(NSDictionary *)currently {
    [_activityIndicator stopAnimating];
    [_iconImageView setImage:[UIImage imageNamed:currently[@"icon"]]];
    [_location setText:_zipCodeData[@"location"]];
    [_summary setText:currently[@"summary"]];
    [_temperature setText:[NSString stringWithFormat:@"%li°",[currently[@"apparentTemperature"] integerValue]]];
}

- (IBAction)dissmissViewController:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
