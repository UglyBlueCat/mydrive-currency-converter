//
//  DataHandler.h
//  CurrencyConverter
//
//  Created by Robin Spinks on 12/07/2015.
//  Copyright (c) 2015 Robin Spinks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataHandler : NSObject

@property NSMutableArray* currencies;

+ (DataHandler*)sharedInstance;
- (void)loadFromURL:(NSURL*)url;
- (float)rateFrom:(NSString*)from To:(NSString*)to;

@end
