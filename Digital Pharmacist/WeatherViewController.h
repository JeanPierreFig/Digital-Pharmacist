//
//  WeatherViewController.h
//  Digital Pharmacist
//
//  Created by Jean Pierre on 8/29/18.
//  Copyright © 2018 Jean Pierre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherCollectionViewCell.h"

@interface WeatherViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *summary;
@property (weak, nonatomic) IBOutlet UILabel *temperature;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSDictionary *zipCodeData;
@property (strong, nonatomic) NSDictionary *data;


-(IBAction)dissmissViewController:(id)sender;
-(void)getWeather;
-(void)displayWeather:(NSDictionary* )currently;
- (NSString *)convertUnix:(NSString *)unix;
@end
