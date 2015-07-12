//
//  DataHandler.h
//  CurrencyConverter
//
//  Created by Robin Spinks on 12/07/2015.
//  Copyright (c) 2015 Robin Spinks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataHandler : NSObject

+ (DataHandler*)sharedInstance;
- (void)loadFromURL:(NSURL*)url;

@end
