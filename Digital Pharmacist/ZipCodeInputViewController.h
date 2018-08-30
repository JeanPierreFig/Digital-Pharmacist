//
//  ZipCodeInputViewController.h
//  Digital Pharmacist
//
//  Created by Jean Pierre on 8/29/18.
//  Copyright © 2018 Jean Pierre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherViewController.h"

@protocol ZipCodeDelegate <NSObject>
    -(void)didAddZipCode:(NSDictionary*)zipCodeData;
@end

@interface ZipCodeInputViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UILabel *locationText;
@property (weak) id <ZipCodeDelegate> delegate;
@property (nonatomic, assign, getter=isValidZipCode) BOOL validZipCode;
@property (strong, nonatomic) NSDictionary *zipCodeData;

-(void)getLocationFrom:(NSString*)zip;

- (IBAction)dissmissViewController:(id)sender;
- (IBAction)addZipCode:(id)sender;

@end
