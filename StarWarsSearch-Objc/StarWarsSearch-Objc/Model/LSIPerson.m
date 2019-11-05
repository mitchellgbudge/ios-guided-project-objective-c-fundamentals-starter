//
//  LSIPerson.m
//  StarWarsSearch-Objc
//
//  Created by Mitchell Budge on 11/5/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "LSIPerson.h"

@implementation LSIPerson

- (instancetype)initWithName:(NSString *)name
                   birthYear:(NSString *)birthYear
                      height:(NSString *)height
                    eyeColor:(NSString *)eyeColor {
    if (self = [super init]) {
        _name = name;
        _birthYear = birthYear;
        _height = height;
        _eyeColor = eyeColor;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    NSString *birthYear = dictionary[@"birth_year"];
    NSString *height = dictionary[@"height"];
    NSString *eyeColor = dictionary[@"eye_color"];
    return [self initWithName:name birthYear:birthYear height:height eyeColor:eyeColor];
}


@end
