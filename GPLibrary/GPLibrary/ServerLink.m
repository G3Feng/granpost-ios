//
//  ServerLink.m
//  tableApp
//
//  Created by Feng on 2013-09-02.
//  Copyright (c) 2013 GP. All rights reserved.
//

#import "ServerLink.h"

@implementation ServerLink

static ServerLink* _instance = nil;

+(ServerLink*)instance;
{
    @synchronized([ServerLink class])
    {
        if (!_instance) {
            _instance = [[ServerLink alloc]init];
        }
        return _instance;
    }
    return nil;
}

+(id)alloc
{
    @synchronized([ServerLink class])
    {
        NSAssert(_instance == nil, @"Atempted to allocate a second instance of a singleton.");
        _instance = [super alloc];
        return _instance;
    }
    return nil;
}

-(id)init {
    self = [super init];
    NSArray* articles=@[
                         @{  @"title":@"hello",
                             @"body":@"hellow world!!!",
                             @"comment":@[@"Good!",@"I like it.",@"I agree.",@"What?"]
                             },
                         @{  @"title":@"forum created",
                             @"body":@"This forum is created on Sep 2, 2013",
                             @"comment":@[@"Good!",@"I like it.",@"I agree.",@"What?"]
                             }
                         ];
    //    if (!_objects) {
    //        _objects = [[NSMutableArray alloc] init];
    //    }
    //    [_objects insertObject:[NSDate date] atIndex:0];
    //    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    //    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

    self.articleList=[[NSMutableArray alloc] init];
    for (int i=0;i<articles.count;i++){
        NSLog(@"title: %@",[articles[i] valueForKeyPath:@"title"]);
        [self.articleList insertObject:articles[i] atIndex:0];
    }
    
    return self;
}


@end
