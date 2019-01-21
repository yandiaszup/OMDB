//
//  StoredFavoritesController.m
//  Movie
//
//  Created by Yan Lucas Damasceno Dias on 21/01/19.
//  Copyright © 2019 a. All rights reserved.
//

#import "StoredFavoritesController.h"
#import "AppDelegate.h"

@implementation StoredFavoritesController

static StoredFavoritesController *instance = nil;


+(id) instance {
    if (instance == nil){
        instance = [[StoredFavoritesController alloc]init];
    }
    return instance;
}

-(NSArray*) favoriteMovies{
    AppDelegate *appDelegate;
    NSManagedObjectContext *context;
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    context = appDelegate.persistentContainer.viewContext;

    NSFetchRequest *requestMovie = [NSFetchRequest fetchRequestWithEntityName:@"Movies"];
    NSArray *results = [context executeFetchRequest:requestMovie error:nil];
    return results;
}

@end
