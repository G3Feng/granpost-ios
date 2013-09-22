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
                        @{
                            @"title":@"hello大家好",
                            @"body":@"hellow world!!!我出来了",
                            @"user":@"blackgun",
                            @"createdAt": @"2013-09-12T03:15:21.436Z",
                            @"comments":@[
                                    @{@"body":@"欢迎欢迎.It would seem to me that there could be another culprit for the problem of cells stacking on top of each other and not being reused. 传统上,\"陶瓷\"(ceramic)是陶器、炻器和瓷器的通称. 这些传统陶瓷制品是采用天然矿物原料(如黏土、长石、石英等)及少量的化工原料,经配料、粉碎加工、成形、烧成等工艺所制成的. 它包括日用陶瓷、艺术陈设陶瓷、建筑卫生陶瓷、电瓷、化工陶瓷等. ",@"user":@"Mike",@"createdAt": @"2013-09-15T03:15:21.436Z"},
                                    @{@"body":@"很高兴见到你.Stupid refresh on my iPhone made me miss the fact that this already worked for you. And instead wrote up this long response...",@"user":@"Tom",@"createdAt": @"2013-09-17T08:35:21.436Z"},
                                    @{@"body":@"你从哪里来的. Interesting problem. You said your cell dequeuing is returning nil. Has this been confirmed with breakpoints or logs? Or is this a mere deduction from the images that you posted?",@"user":@"Jack",@"createdAt": @"2013-09-19T09:25:21.436Z"}
                            ]
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
