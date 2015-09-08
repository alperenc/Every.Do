//
//  AddTodoViewController.h
//  Every.Do
//
//  Created by Alp Eren Can on 08/09/15.
//  Copyright © 2015 Alp Eren Can. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"

@protocol AddTodoDelegate <NSObject>

- (void)addTodo:(Todo *)todo;

@end

@interface AddTodoViewController : UIViewController

@property (weak, nonatomic) id<AddTodoDelegate> delegate;

@end
