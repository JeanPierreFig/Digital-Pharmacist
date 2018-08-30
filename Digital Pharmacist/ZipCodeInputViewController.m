//
//  ZipCodeInputViewController.m
//  Digital Pharmacist
//
//  Created by Jean Pierre on 8/29/18.
//  Copyright © 2018 Jean Pierre. All rights reserved.
//

#import "ZipCodeInputViewController.h"

@interface ZipCodeInputViewController ()

@end

@implementation ZipCodeInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _inputTextField.delegate = self;
    _locationText.text = @"";
}

- (void)viewDidAppear:(BOOL)animated {
    [_inputTextField becomeFirstResponder];
}

- (void)getLocationFrom:(NSString*)zip {
    NSString *dataUrl = [NSString stringWithFormat:@"https://www.zipcodeapi.com/rest/kglUqtUpo9CjGd5IGgvslPPUri1QzAeo9B35Z4Rh0T50854a0Hq32DRlfPGLxdyd/info.json/%@/degrees",zip];
    NSURL *url = [NSURL URLWithString:dataUrl];

    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
    dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSError *jsonError;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
        if (jsonError) {
            NSLog(@"%@", jsonError.localizedDescription);
            return;
        }
        if (dict[@"city"] && dict[@"state"] && dict[@"lat"] && dict[@"lng"]) {
            NSString *location  = [NSString stringWithFormat:@"%@, %@",dict[@"city"],dict[@"state"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.zipCodeData = @{@"zipCode":zip,@"lat":dict[@"lat"],@"lng":dict[@"lng"],@"location":location};
                self.locationText.text = location;
                //The zip code is valid. The user can added it to the list.
                [self setValidZipCode:YES];
            });
        }
        else {
            NSLog(@"Error with the API. Problibly limit exceeded.");
        }
    }];
    
    [downloadTask resume];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"InitDetail"]) {
        WeatherViewController *destination = [segue destinationViewController];
        destination.zipCodeData = _zipCodeData;
    }
}

- (IBAction)dissmissViewController:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)addZipCode:(id)sender {
    if (self.isValidZipCode) {
        [self.view endEditing:YES];
        [_delegate didAddZipCode:_zipCodeData];
        [self performSegueWithIdentifier:@"InitDetail" sender:nil];
   }
    else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Not a valid zip code." message:@"Other reason for this message to show is because the zip to GPS API limit is exceeded." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (range.location >= 4) {
        [self getLocationFrom:[NSString stringWithFormat:@"%@%@",textField.text,string]];
    }
    else {
        _locationText.text = @"";
        [self setValidZipCode:NO];
    }
    return (range.location > 4) ? NO : YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
