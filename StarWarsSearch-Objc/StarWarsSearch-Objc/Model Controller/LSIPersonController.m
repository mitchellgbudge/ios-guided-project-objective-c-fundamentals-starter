//
//  LSIPersonController.m
//  StarWarsSearch-Objc
//
//  Created by Mitchell Budge on 11/5/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "LSIPersonController.h"
#import "LSIPerson.h"

@implementation LSIPersonController

static NSString *const baseURLString = @"https://swapi.co/api/people";

- (void)searchForPeopleWithSearchTerm:(NSString *)searchTerm
                           completion:(void (^)(NSArray *people, NSError *error))completion {
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURLComponents *components = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    NSURLQueryItem *searchItem = [NSURLQueryItem queryItemWithName:@"search" value:searchTerm];
    [components setQueryItems: @[searchItem]];
    
    NSURL *url = [components URL];
    NSLog(@"URL: %@", url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"Search results");
        
        if (error) {
            completion(nil, error);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            completion(nil, error);
            return;
        }
        
        if (![json isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON was not a dictionary as expected");
            completion(nil, [[NSError alloc] init]);
        }
        
        NSArray *results = json[@"results"];
        NSMutableArray *people = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dictionary in results) {
            LSIPerson *person = [[LSIPerson alloc] initWithDictionary:dictionary];
            [people addObject:person];
        }
        completion(people, nil);
    
    }];
    [task resume];
}

@end
