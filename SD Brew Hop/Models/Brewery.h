//
//  Brewery.h
//  SD Brew Hop
//
//  Created by Developer on 11/20/13.
//  Copyright (c) 2013 Adam Zaninovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDBHClient.h"

@interface Brewery : NSObject

+ (NSURLSessionDataTask *)loadBreweriesWithCompletion:(void(^)(NSArray *breweries))completion;
- (id)initWithDictionary:(NSDictionary *)attributes;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *endpoint;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic) int *hopCount;


@end
