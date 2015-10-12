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
#import "Reachability.h"

@implementation RottenTomatoesAPI

+(void) writeJSONtoDisk:(NSData*)data{
    //get the documents directory:
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *fileName = [NSString stringWithFormat:@"%@/movieJson.json",documentsDirectory];
    //create content - four lines of text

    //save content to the documents directory
    [data writeToFile:fileName atomically:YES];
    
}

+(NSData*) getJSONFromDisk{
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *fileName = [NSString stringWithFormat:@"%@/movieJson.json",
                          documentsDirectory];
    return [[NSData alloc] initWithContentsOfFile:fileName];
}

+(void)loadNewMoviesAndReturnToDataSource:(MovieDataSource*)movieDataSource{
    
    NSLog(@"RottenTomatoesAPI::getMovies start");
    
    NSUserDefaults *defaults;
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) { // no internet, don't do anything
         defaults = [NSUserDefaults standardUserDefaults];
        NSData *data = [RottenTomatoesAPI getJSONFromDisk];
        if(data != nil){
            NSLog(@"movie json pulled from disk...");
            NSMutableArray *movieArray = [[NSMutableArray alloc]init];
        NSError *jsonError = nil;
        NSArray *movieJson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        for (NSDictionary *movieListing in [movieJson valueForKey:@"movies"]) {
            
            Movie *movie = [[Movie alloc]init];
            movie.title = [movieListing valueForKey:@"movie_name"];
            movie.imageUrl = [movieListing valueForKey:@"image_url"];
            movie.rating = [NSString stringWithFormat:@"Rating: %@",[movieListing valueForKey:@"rating"]];
            movie.desc = [movieListing valueForKey:@"description"];
            [self loadImage:movie];
            
            [movieArray addObject:movie];
        }

            [movieDataSource setNewMovies:movieArray];

        }

    } else { // there is internet connection
        
        NSURLSession *session = [NSURLSession sharedSession];
        
        [[session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:WEBSERVICE_URL]]
                    completionHandler:^(NSData *data,
                                        NSURLResponse *response,
                                        NSError *error) {
                        if (error != nil) {
                            NSLog(@"Error with webservice: %@",error.description);
                            
                        }else{
                            
                            NSMutableArray *movieArray = [[NSMutableArray alloc]init];
                            
                            NSLog(@"data: %@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
                            
                            [RottenTomatoesAPI writeJSONtoDisk:data];
                            
                            NSError *jsonError = nil;
                            NSArray *movieJson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
                            for (NSDictionary *movieListing in [movieJson valueForKey:@"movies"]) {
                                
                                Movie *movie = [[Movie alloc]init];
                                movie.title = [movieListing valueForKey:@"movie_name"];
                                movie.imageUrl = [movieListing valueForKey:@"image_url"];
                                movie.rating = [NSString stringWithFormat:@"Rating: %@",[movieListing valueForKey:@"rating"]];
                                movie.desc = [movieListing valueForKey:@"description"];
                                [self loadImage:movie];
                                
                                [movieArray addObject:movie];
                            }
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                if ([[NSThread currentThread] isMainThread]){
                                    [movieDataSource setNewMovies:movieArray];
                                }
                            });
                            
                            
                            
                        }
                        
                    }] resume];
        
        [session finishTasksAndInvalidate];
    }
}

+(void) loadImages:(NSArray*) movies{
    
    for(Movie *movie in movies){
        [self loadImage:movie];
    }
    
}

+(void) loadImage:(Movie*) movie{
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
    config.URLCache = [NSURLCache sharedURLCache];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    [[session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:movie.imageUrl]] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error!=nil){
            NSLog(@"Error with getting image: %@",error.description);
        }
        movie.posterImg = [UIImage imageWithData:data];
        NSLog(@"ImageSize: %f, %f", movie.posterImg.size.width, movie.posterImg.size.height);
        NSLog(@"DiskCache: %lu of %lu", (unsigned long)[[NSURLCache sharedURLCache] currentDiskUsage], (unsigned long)[[NSURLCache sharedURLCache] diskCapacity]);
        NSLog(@"MemoryCache: %lu of %lu", (unsigned long)[[NSURLCache sharedURLCache] currentMemoryUsage], (unsigned long)[[NSURLCache sharedURLCache] memoryCapacity]);
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[NSThread currentThread] isMainThread]){
                movie.imageView.image = movie.posterImg;
            }
        });
        
    }] resume];
    
    [session finishTasksAndInvalidate];
    
}


@end
