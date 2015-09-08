//
//  Todo.m
//  Every.Do
//
//  Created by Alp Eren Can on 08/09/15.
//  Copyright © 2015 Alp Eren Can. All rights reserved.
//

#import "Todo.h"

@implementation Todo

- (instancetype)initWithTitle:(NSString *)title details:(NSString *)details prioroty:(Priority)priorityNumber
{
    self = [super init];
    if (self) {
        self.title = title;
        self.details = details;
        self.priorityNumber = priorityNumber;
        self.completed = NO;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title details:(NSString *)details
{
    return [[Todo alloc] initWithTitle:title details:details prioroty:Low];
}

- (NSString *)priorityToString:(Priority)priority {
    switch (priority) {
        case 0:
            return @"Low";
            break;
        case 1:
            return @"High";
            break;
        case 2:
            return @"Critical";
            break;
        default:
            return @"Priorty not set.";
            break;
    }
}

@end
