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

- (IBAction)dissmissViewController:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)addZipCode:(id)sender {
    [_delegate didAddZipCode:_inputTextField.text];
    [self dissmissViewController:self];
}


#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return (range.location > 4) ? NO : YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
