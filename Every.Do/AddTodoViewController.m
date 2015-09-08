//
//  AddTodoViewController.m
//  Every.Do
//
//  Created by Alp Eren Can on 08/09/15.
//  Copyright © 2015 Alp Eren Can. All rights reserved.
//

#import "AddTodoViewController.h"

@interface AddTodoViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *detailsTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegmentedControl;

@end

@implementation AddTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismiss)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(addTodoItem)];
    self.navigationItem.rightBarButtonItem = doneButton;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

-(void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addTodoItem {
    Todo *todo = [[Todo alloc] initWithTitle:self.titleTextField.text details:self.detailsTextField.text priority:self.prioritySegmentedControl.selectedSegmentIndex];
    
    [self.delegate addTodo:todo];

    [self dismiss];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
