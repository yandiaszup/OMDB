//
//  SearchMovieRequest.h
//  Movie
//
//  Created by Yan Lucas Damasceno Dias on 15/01/19.
//  Copyright © 2019 a. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"
NS_ASSUME_NONNULL_BEGIN

@interface SearchMovieRequest : NSObject
{
    int page;
}

+(id) instance;
-(NSMutableArray*) searchMovie: (NSString *)title;
-(NSMutableArray*) searchPosterURL: (NSString*) movieID;
-(Movie*) searchMovieByID: (NSString*) movieID;
-(void)setData;

@end

NS_ASSUME_NONNULL_END
