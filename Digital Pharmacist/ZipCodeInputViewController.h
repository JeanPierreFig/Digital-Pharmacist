//
//  ZipCodeInputViewController.h
//  Digital Pharmacist
//
//  Created by Jean Pierre on 8/29/18.
//  Copyright © 2018 Jean Pierre. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZipCodeDelegate <NSObject>
    -(void)didAddZipCode:(NSString*)code;
@end

@interface ZipCodeInputViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak) id <ZipCodeDelegate> delegate;

- (IBAction)dissmissViewController:(id)sender;
- (IBAction)addZipCode:(id)sender;

@end