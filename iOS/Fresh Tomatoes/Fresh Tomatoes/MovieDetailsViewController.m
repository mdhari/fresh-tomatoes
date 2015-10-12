//
//  MovieDetailsViewController.m
//  Fresh Tomatoes
//
//  Created by Michael Hari on 10/10/15.
//  Copyright © 2015 Michael Hari. All rights reserved.
//

#import "MovieDetailsViewController.h"

@interface MovieDetailsViewController ()

@end

@implementation MovieDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    self.movieTitleLbl.text = self.movie.title;
    self.movieRatingLbl.text = self.movie.rating;
    self.descriptionTxtView.text = self.movie.desc;
    self.descriptionTxtView.scrollEnabled = NO;
    self.descriptionTxtView.textContainer.maximumNumberOfLines = 0;
    self.descriptionTxtView.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
    if(self.movie.posterImg != nil){
        self.movieImageView.image = self.movie.posterImg;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 * User pressed back button on modal, just dismiss it.
 */
- (IBAction)backBtnPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
