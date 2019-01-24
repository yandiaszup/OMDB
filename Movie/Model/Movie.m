//
//  Movie.m
//  filmes1
//
//  Created by Yan Lucas Damasceno Dias on 14/01/19.
//  Copyright © 2019 a. All rights reserved.
//

#import "Movie.h"
#import "AppDelegate.h"

@implementation Movie

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"xablau";

    }
    return self;
}

-(id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if(self) {
        self.title = dictionary[@"Title"];
        self.runtime = dictionary[@"Runtime"];
        self.released = dictionary[@"Released"];
        self.director = dictionary[@"Director"];
        self.genre = dictionary[@"Genre"];
        self.writer = dictionary[@"Writer"];
        self.actors = dictionary[@"Actors"];
        self.plot = dictionary[@"Plot"];
        self.poster = dictionary[@"Poster"];
        self.imdbRating = dictionary[@"imdbRating"];
        self.production = dictionary[@"Production"];
        self.awards = dictionary[@"Awards"];
        self.posterImage = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.poster]];
    }
    return self;
}

-(id)initWithEntity:(NSString *)dictionary{
    self = [super init];
    if(self){
        self.title = [dictionary valueForKey:@"title"];
        self.runtime = [dictionary valueForKey:@"runtime"];
        self.released = [dictionary valueForKey:@"released"];
        self.director = [dictionary valueForKey:@"director"];
        self.genre = [dictionary valueForKey:@"genre"];
        self.writer = [dictionary valueForKey:@"writer"];
        self.actors = [dictionary valueForKey:@"actor"];
        self.plot = [dictionary valueForKey:@"plot"];
        self.poster = [dictionary valueForKey:@"poster"];
        self.imdbRating = [dictionary valueForKey:@"imdbRating"];
        self.production = [dictionary valueForKey:@"production"];
        self.awards = [dictionary valueForKey:@"awards"];
        self.posterImage = [dictionary valueForKey:@"posterImage"];
    }
    return self;
}

-(void)storeAtributes: (NSManagedObject *) obj{
    [obj setValue:self.title forKey:@"title"];
    [obj setValue:self.runtime forKey:@"runtime"];
    [obj setValue:self.released forKey:@"released"];
    [obj setValue:self.director forKey:@"director"];
    [obj setValue:self.genre forKey:@"genre"];
    [obj setValue:self.writer forKey:@"writer"];
    [obj setValue:self.actors forKey:@"actor"];
    [obj setValue:self.plot forKey:@"plot"];
    NSURL *image = [NSURL URLWithString:self.poster];
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:image];
    UIImage *image1 = [[UIImage alloc] initWithData:imageData];
    NSData *storedImage = UIImageJPEGRepresentation(image1, 0.0);
    [obj setValue:storedImage forKey:@"posterImage"];
    [obj setValue:self.poster forKey:@"poster"];
    [obj setValue:self.imdbRating forKey:@"imdbRating"];
    [obj setValue:self.production forKey:@"production"];
    [obj setValue:self.awards forKey:@"awards"];
}

-(void) test{
    NSLog(@"%@",self.title);
    NSLog(@"%@",self.runtime);
    NSLog(@"%@",self.released);
    NSLog(@"%@",self.director);
    NSLog(@"%@",self.genre);
    NSLog(@"%@",self.writer);
    NSLog(@"%@",self.actors);
    NSLog(@"%@",self.plot);
    NSLog(@"%@",self.poster);
    NSLog(@"%@",self.imdbRating);
    NSLog(@"%@",self.production);
    NSLog(@"%@",self.awards);
}
@end
