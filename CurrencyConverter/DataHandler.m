//
//  DataHandler.m
//  CurrencyConverter
//
//  Created by Robin Spinks on 12/07/2015.
//  Copyright (c) 2015 Robin Spinks. All rights reserved.
//

#import "DataHandler.h"

@interface DataHandler ()

@property NSDictionary* rawCurrencyData;
@property NSMutableDictionary* dollarValues;

@end

@implementation DataHandler {
    BOOL dataAvailable;
}

// Set up the data handler as a singleton
+ (DataHandler*)sharedInstance {
    static DataHandler* _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[DataHandler alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _dollarValues = [NSMutableDictionary new];
        _currencies = [NSMutableArray new];
    }
    return self;
}

// attempt to download data
// This could be improved with backgrounding and retries etc, using a networking class, but in this case the data is so small it's not really necessary.
- (void)loadFromURL:(NSURL*)url {
    dataAvailable = YES;
    NSString* currencyDataFile = [[NSBundle mainBundle] pathForResource:@"currencyDataFile" ofType:@"json"];
    NSError* __autoreleasing error = nil;
    
    NSData* jsonData = [NSData dataWithContentsOfURL:url options:0 error:&error];
    
    if (error) {
        NSLog(@"%s Data download error: %@", __PRETTY_FUNCTION__, error.debugDescription);
        NSLog(@"%s Attempting to load from file...", __PRETTY_FUNCTION__);
        jsonData = [NSData dataWithContentsOfFile:currencyDataFile options:0 error:&error];
        if (error) {
            NSLog(@"%s Data file error: %@", __PRETTY_FUNCTION__, error.debugDescription);
            dataAvailable = NO;
        }
    } else {
        [jsonData writeToFile:currencyDataFile atomically:YES];
    }
    
    if (dataAvailable) {
        id object = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        self.rawCurrencyData = [NSDictionary dictionaryWithDictionary:(NSDictionary *)object];
        [self parseData];
    } else {
        // TODO: retry or alert user
    }
}

// Go through the mixed conversion rates and save them all as dollar values
- (void)parseData {
    for (NSDictionary* conversionRate in self.rawCurrencyData[@"conversions"]) {
        if ([(NSString*)conversionRate[@"to"] isEqualToString:@"USD"]) {
            [self.currencies addObject:conversionRate[@"from"]];
            [self.dollarValues setObject:conversionRate[@"rate"] forKey:conversionRate[@"from"]];
        } else if ([(NSString*)conversionRate[@"from"] isEqualToString:@"USD"]) {
            [self.currencies addObject:conversionRate[@"to"]];
            float rate = 1/[conversionRate[@"rate"] floatValue];
            NSString* rateString = [NSString stringWithFormat:@"%1.5f", rate];
            [self.dollarValues setObject:rateString forKey:conversionRate[@"to"]];
        } else {
            // TODO: Contingency
        }
    }
    // Nearly forgot US dollars..
    [self.currencies addObject:@"USD"];
    [self.dollarValues setObject:@"1" forKey:@"USD"];
    NSLog(@"%s\n\ncurrencies:\n%@", __PRETTY_FUNCTION__, self.currencies);
    NSLog(@"%s\n\ndollarValues:\n%@", __PRETTY_FUNCTION__, self.dollarValues);
}

// Give a conversion rate from one curency to another
- (float)rateFrom:(NSString*)from To:(NSString*)to {
    float fromRate = [self.dollarValues[from] floatValue];
    float toRate = [self.dollarValues[to] floatValue];
    return fromRate/toRate;
}

@end
