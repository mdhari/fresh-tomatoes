//
//  ViewController.m
//  Fresh Tomatoes
//
//  Created by Michael Hari on 10/8/15.
//  Copyright © 2015 Michael Hari. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"ViewController::viewDidLoad");
    
    self.dataSource = [[MovieDataSource alloc]init];
    
    // initialize the movie tables delegate and datasource
    self.movieTableView.delegate=self;
    self.movieTableView.dataSource=self.dataSource;
    
    [self populateMovies];
    

}

- (void) populateMovies{
    NSLog(@"ViewController::populateMovies");
    
    [self.dataSource loadNewMovies:self.movieTableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
