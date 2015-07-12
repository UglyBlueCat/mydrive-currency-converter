//
//  ViewController.m
//  CurrencyConverter
//
//  Created by Robin Spinks on 12/07/2015.
//  Copyright (c) 2015 Robin Spinks. All rights reserved.
//

#import "ViewController.h"
#import "DataHandler.h"

@interface ViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property IBOutlet UITextField* fromAmount;
@property IBOutlet UILabel* toAmount;
@property IBOutlet UIPickerView* fromPicker;
@property IBOutlet UIPickerView* toPicker;
@property DataHandler* dataHandler;

@end

@implementation ViewController

#pragma mark custom methods

- (IBAction)calculateToValue {
    NSString* fromCurrency = self.dataHandler.currencies[[self.fromPicker selectedRowInComponent:0]];
    NSString* toCurrency = self.dataHandler.currencies[[self.toPicker selectedRowInComponent:0]];
    float amountToConvert = self.fromAmount.text.floatValue;
    float rate = [self.dataHandler rateFrom:fromCurrency To:toCurrency];
    float convertedAmount = amountToConvert * rate;
    self.toAmount.text = [NSString stringWithFormat:@"%1.2f", convertedAmount];
}

#pragma mark ViewController methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataHandler = [DataHandler sharedInstance];
    [self calculateToValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIPickerViewDataSource methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataHandler.currencies.count;
}

#pragma mark UIPickerViewDelegate methods

- (NSString*)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.dataHandler.currencies[row];
}

- (void)pickerView:(UIPickerView*)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self calculateToValue];
}

@end
