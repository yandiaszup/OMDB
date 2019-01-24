//
//  SearchMovieRequest.m
//  Movie
//
//  Created by Yan Lucas Damasceno Dias on 15/01/19.
//  Copyright © 2019 a. All rights reserved.
//

#import "SearchMovieRequest.h"
#import "Movie.h"
#import "Reachability.h"
#import "AFNetworking.h"

@implementation SearchMovieRequest

static SearchMovieRequest *instance = nil;

+(id) instance {
    if (instance == nil){
        instance = [[SearchMovieRequest alloc]init];
    }
    return instance;
}

-(void)setData{
    page = 0;
}

- (NSURLSessionTask *)test:(NSString*) title success:(void (^)(NSMutableArray *dic))success{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURL *URL = [NSURL URLWithString:[self buildURL:title]];
    
    return [manager GET:URL.absoluteString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        success(NULL);

    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
    }];
}


-(NSMutableArray*) searchMovie: (NSString *) title {
    NSString *urlstring = [self buildURL:title];
    NSError *err;
    NSMutableArray *postersURL = [[NSMutableArray alloc] init];
    
    NSData *data =  [NSData dataWithContentsOfURL:[NSURL URLWithString:urlstring]];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
    for (NSDictionary *movieDict in json[@"Search"]){
        NSString *poster = movieDict[@"imdbID"];
        [postersURL addObject:poster];
    }
    return postersURL;
}

-(NSMutableArray*) searchPosterURL: (NSString*) movieID {
    NSString *urlString = [NSString stringWithFormat:@"https://www.omdbapi.com/?s=%@&page=%d&apikey=56c108cd",movieID,page];
    urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSError *err;
    NSMutableArray *postersURL = [[NSMutableArray alloc] init];
    NSData *data =  [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
    for (NSDictionary *movieDict in json[@"Search"]){
        NSString *poster = movieDict[@"Poster"];
        [postersURL addObject:poster];
    }
    return postersURL;
}

-(Movie*) searchMovieByID: (NSString*) movieID {
    NSString *urlString = [NSString stringWithFormat:@"https://www.omdbapi.com/?i=%@&apikey=56c108cd",movieID];
    NSError *err;
    NSData *data =  [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
    Movie *movie = [[Movie alloc] initWithDictionary:json];
    return movie;
}

-(void)addPage{
    page += 1;
}

-(NSString*) buildURL: (NSString *) title {
    [self addPage];
    NSString *newTitle = [title stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString *apiKey = [NSString stringWithFormat:@"&apikey=56c108cd"];
    NSString *finalURL = [NSString stringWithFormat:@"https://www.omdbapi.com/?s=%@&page=%d%@",newTitle,page,apiKey];
    return finalURL;
}

@end
