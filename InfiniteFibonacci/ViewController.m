//
//  ViewController.m
//  InfiniteFibonacci
//
//  Created by Ankur Gupta on 3/9/15.
//  Copyright (c) 2015 Ankur Gupta. All rights reserved.
//

#import "ViewController.h"
#import "GlobalFibonacciGenerator.h"

#define k_fibIncremental 20; //Numer of fibonacci numbers incremented
                            // once we hit the bottom of existing set

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewData = [[NSMutableArray alloc] init];
    //Initialize the table with some fibonacci numbers
    [self addMoreFibonacciNumbers];
}

- (void)loadView
{
    //Setup the table to display the numbers
    UITableView *tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView reloadData];
    
    self.view = tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableViewData.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row < self.tableViewData.count) {
        cell.textLabel.text = [self.tableViewData objectAtIndex:indexPath.row];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.textLabel.minimumScaleFactor = 0.4;
    } else {
        cell.textLabel.text = NSLocalizedString(@"Getting more fibonacci numbers...", nil);
        
        //Check the table loading lock and show more Fibonacci numbers
        if (!self.loadingMoreTableViewData) {
            self.loadingMoreTableViewData = YES;
            
            //Make async call to load more fib numbers (not blocking main thread)
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                [self addMoreFibonacciNumbers];
                //Reload table on main thread
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self refreshTable];
                });
            });
           
        }
    }
    
    return cell;
}

//Add more fibonacci numbers to the table
- (void)addMoreFibonacciNumbers {
    int totalFibNumbers = (int)self.tableViewData.count + k_fibIncremental;
    while (self.tableViewData.count < totalFibNumbers) {
        [self.tableViewData addObject:[NSString stringWithFormat:@"%@", [[GlobalFibonacciGenerator sharedGenerator] nextFibonacciNumber]]];
    };
}

//Reload the table and clear out the table loading lock
-(void)refreshTable{
    [self.tableView reloadData];
    self.loadingMoreTableViewData = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
