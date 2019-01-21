//
//  StoredFavoritesController.h
//  Movie
//
//  Created by Yan Lucas Damasceno Dias on 21/01/19.
//  Copyright © 2019 a. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoredFavoritesController : NSObject
-(NSArray*) favoriteMovies;
+(id) instance;
@end

NS_ASSUME_NONNULL_END
