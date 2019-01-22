//
//  Movie.h
//  filmes1
//
//  Created by Yan Lucas Damasceno Dias on 14/01/19.
//  Copyright © 2019 a. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface Movie : NSObject

@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *runtime;
@property (strong,nonatomic) NSString *released;
@property (strong,nonatomic) NSString *director;
@property (strong,nonatomic) NSString *genre;
@property (strong,nonatomic) NSString *writer;
@property (strong,nonatomic) NSString *actors;
@property (strong,nonatomic) NSString *plot;
@property (strong,nonatomic) NSString *poster;
@property (strong,nonatomic) NSString *imdbRating;
@property (strong,nonatomic) NSString *production;
@property (strong,nonatomic) NSString *awards;

-(id) initWithDictionary: (NSDictionary*) dictionary;
-(id)initWithEntity:(NSString *)dictionary;
-(void)storeAtributes: (NSManagedObject *) obj;
-(void) test;

@end



