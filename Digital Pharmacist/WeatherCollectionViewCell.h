//
//  weatherCollectionViewCell.h
//  Digital Pharmacist
//
//  Created by Jean Pierre on 8/30/18.
//  Copyright © 2018 Jean Pierre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *temperature;
@property (weak, nonatomic) IBOutlet UILabel *time;


@end
