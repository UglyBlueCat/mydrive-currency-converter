//
//  DataHandler.m
//  CurrencyConverter
//
//  Created by Robin Spinks on 12/07/2015.
//  Copyright (c) 2015 Robin Spinks. All rights reserved.
//

#import "DataHandler.h"

@interface DataHandler ()

@property NSArray* rawCurrencyData;

@end

@implementation DataHandler

// Set up the data handler as a singleton
+ (DataHandler*)sharedInstance {
    
    static DataHandler* _sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[DataHandler alloc] init];
    });
    
    return _sharedInstance;
}

// attempt to download data
// This could be improved with backgrounding and retries etc, using a networking class, but in this case the data is so small it's not really necessary.
- (void)loadFromURL:(NSURL*)url {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"json" ofType:@"txt"];
    NSData* jsonData = [NSData dataWithContentsOfURL:url];
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    
    if (error) {
        // TODO: Check for existence of file & load
    } else {
        self.rawCurrencyData = [NSArray arrayWithObject:object];
        // TODO: save data to file
    }
    
    NSLog(@"%s\n\nrawCurrencyData:\n%@", __PRETTY_FUNCTION__, self.rawCurrencyData);
}

@end
