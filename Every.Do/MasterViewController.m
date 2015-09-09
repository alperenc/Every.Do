//
//  MasterViewController.m
//  Every.Do
//
//  Created by Alp Eren Can on 08/09/15.
//  Copyright © 2015 Alp Eren Can. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "AddTodoViewController.h"
#import "Todo.h"
#import "TodoTableViewCell.h"

@interface MasterViewController () <AddTodoDelegate>

@property NSMutableArray *todos;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    self.todos = [@[[[Todo alloc]initWithTitle:@"Every.Do"
                                       details:@"Make a todo app for Lighthouse Labs W3D2."
                                      priority:Critical],
                    [[Todo alloc]initWithTitle:@"W3D1: Readings"
                                       details:@"Do the readings for W3D1 and answer questions."
                                      priority:High],
                    [[Todo alloc]initWithTitle:@"W3D1: Image Galleries"
                                       details:@"Implement stretch goals 3 & 4."],
                    [[Todo alloc]initWithTitle:@"W2E: Q2"
                                       details:@"Do the exercise in second weekend's questions."]] mutableCopy];
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    
    AddTodoViewController *addTodoVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AddTodoViewController"];
    addTodoVC.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addTodoVC];
    
    [self presentViewController:navController animated:YES completion:nil];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Todo *todo = self.todos[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:todo];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.todos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TodoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodoCell" forIndexPath:indexPath];
    [cell addGestureRecognizer:[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToComplete:)]];
    
    Todo *todo = self.todos[indexPath.row];
    
    if ([todo isCompleted]) {
        
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:todo.title
                                                                              attributes:@{NSStrikethroughStyleAttributeName: @1}];
        cell.todoTitleLabel.attributedText = attributedTitle;
        
        NSAttributedString *attributedDetails = [[NSAttributedString alloc] initWithString:todo.details
                                                                                attributes:@{NSStrikethroughStyleAttributeName: @1}];
        cell.todoDetailsLabel.attributedText = attributedDetails;
        
        NSAttributedString *attributedPriority = [[NSAttributedString alloc] initWithString:[todo priorityToString:todo.priorityNumber]
                                                                                 attributes:@{NSStrikethroughStyleAttributeName: @1}];
        cell.todoPriorityLabel.attributedText = attributedPriority;
        
    } else {
    
        cell.todoTitleLabel.text = [NSString stringWithFormat:@"%@", todo.title];
        cell.todoDetailsLabel.text = [NSString stringWithFormat:@"%@", todo.details];
        cell.todoPriorityLabel.text = [NSString stringWithFormat:@"%@", [todo priorityToString:todo.priorityNumber]];
    }
    
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.todos removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    Todo *todo = [self.todos objectAtIndex:sourceIndexPath.row];
    [self.todos removeObjectAtIndex:sourceIndexPath.row];
    [self.todos insertObject:todo atIndex:destinationIndexPath.row];
    
}

#pragma mark - Add Todo

-(void)addTodo:(Todo *)todo {
    
    if (!self.todos) {
        self.todos = [[NSMutableArray alloc] init];
    }
    
    [self.todos insertObject:todo atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.tableView reloadData];
    
}

- (void)swipeToComplete:(UISwipeGestureRecognizer *)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:[sender locationInView:self.tableView]];
    
    Todo *todo = self.todos[indexPath.row];
    
    if (!todo.completed) {
        todo.completed = YES;
        
        [self.todos removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.todos addObject:todo];
        
        [self.tableView reloadData];
    }
}

@end
