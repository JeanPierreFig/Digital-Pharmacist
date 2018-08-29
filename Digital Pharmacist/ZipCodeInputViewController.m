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
}


- (void)getLocationFrom:(NSString*)zip {
    NSString *dataUrl = [NSString stringWithFormat:@"https://www.zipcodeapi.com/rest/jdgGtqJNwsJkRXtm26y4mItDfryt9ep9wDmwdPk0s7XXPQPh9x4SJehUCPNsj0qP/info.json/%@/degrees",zip];
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
            });
        }
    }];
    
    [downloadTask resume];
}

- (IBAction)dissmissViewController:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)addZipCode:(id)sender {
    [_delegate didAddZipCode:_zipCodeData];
    [self dissmissViewController:self];
}

#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (range.location >= 4) {
        [self getLocationFrom:[NSString stringWithFormat:@"%@%@",textField.text,string]];
    }
    else {
        _locationText.text = @"";
    }
    return (range.location > 4) ? NO : YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
