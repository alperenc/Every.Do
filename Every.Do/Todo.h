//
//  Todo.h
//  Every.Do
//
//  Created by Alp Eren Can on 08/09/15.
//  Copyright © 2015 Alp Eren Can. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, Priority) {
    Low,
    High,
    Critical,
};

@interface Todo : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *details;
@property (nonatomic) Priority priorityNumber;
@property (nonatomic, getter=isCompleted) BOOL completed;

// Designated initializer
- (instancetype)initWithTitle:(NSString *)title details:(NSString *)details priority:(Priority)prioritNumber;

- (instancetype)initWithTitle:(NSString *)title details:(NSString *)details;

- (NSString *)priorityToString:(Priority)priority;

@end
