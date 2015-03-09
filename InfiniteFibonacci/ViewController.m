//
//  ViewController.m
//  InfiniteFibonacci
//
//  Created by Ankur Gupta on 3/9/15.
//  Copyright (c) 2015 Ankur Gupta. All rights reserved.
//

#import "ViewController.h"
#import "GlobalFibonacciGenerator.h"

#define k_fibIncremental 20; //Numer of fibonacci number incremented
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
    } else {
        cell.textLabel.text = @"Getting more Fibonacci numbers...";
        
        //Check the table loading lock and show more Fibonacci numbers
        if (!self.loadingMoreTableViewData) {
            self.loadingMoreTableViewData = YES;
            [self addMoreFibonacciNumbers];
            //Reload table with some delay to let the numbers be generated
            [self performSelector:@selector(refreshTable) withObject:nil afterDelay:0.2f];
        }
    }
    
    return cell;
}

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
