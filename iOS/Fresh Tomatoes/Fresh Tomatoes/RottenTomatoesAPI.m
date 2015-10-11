//
//  RottenTomatoesAPI.m
//  Fresh Tomatoes
//
//  Created by Michael Hari on 10/8/15.
//  Copyright © 2015 Michael Hari. All rights reserved.
//

#import "RottenTomatoesAPI.h"
#import "application-properties.h"
#import "Movie.h"

@implementation RottenTomatoesAPI



+(void)loadNewMoviesAndReturnToDataSource:(MovieDataSource*)movieDataSource{
    
    NSLog(@"RottenTomatoesAPI::getMovies start");
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:WEBSERVICE_URL]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                if (error != nil) {
                    NSLog(@"Error with webservice: %@",error.description);

                }else{
                    
                    NSMutableArray *movieArray = [[NSMutableArray alloc]init];
                    
                    NSLog(@"data: %@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
                    
                    NSError *jsonError = nil;
                    NSArray *movieJson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
                    for (NSDictionary *movieListing in [movieJson valueForKey:@"movies"]) {
                        
                        Movie *movie = [[Movie alloc]init];
                        movie.title = [movieListing valueForKey:@"movie_name"];
                        movie.imageUrl = [movieListing valueForKey:@"image_url"];
                        movie.rating = [movieListing valueForKey:@"rating"];
                        movie.desc = [movieListing valueForKey:@"description"];
                        
                        [movieArray addObject:movie];
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if ([[NSThread currentThread] isMainThread]){
                            [movieDataSource setNewMovies:movieArray];
                        }
                    });
                    
                    
                    
                }
             
            }] resume];
    
}

@end
