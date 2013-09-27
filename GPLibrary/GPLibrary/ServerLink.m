//
//  ServerLink.m
//  tableApp
//
//  Created by Feng on 2013-09-02.
//  Copyright (c) 2013 GP. All rights reserved.
//

#import "ServerLink.h"
#import <RestKit/RestKit.h>
#import "Article.h"

#define apiVersion @"/v1"

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


- (void)setupRestKit1
{
    RKLogConfigureByName("RestKit/Network*", RKLogLevelTrace);
    //    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
    
    //let AFNetworking manage the activity indicator
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    // Initialize HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"http://localhost:3000"];
    AFHTTPClient* client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    // HACK: Set User-Agent to Mac OS X so that Twitter will let us access the Timeline
    [client setDefaultHeader:@"User-Agent" value:[NSString stringWithFormat:@"%@/%@ (Mac OS X %@)", [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleIdentifierKey], [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey], [[NSProcessInfo processInfo] operatingSystemVersionString]]];
    
    //we want to work with JSON-Data
    [client setDefaultHeader:@"Accept" value:RKMIMETypeJSON];
    
    //Get JSON response
    //    client.parameterEncoding = AFJSONParameterEncoding;
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    
    
    // Initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    // Setup our object mappings
    RKObjectMapping *articleMapping = [RKObjectMapping mappingForClass:[Article class]];
    [articleMapping addAttributeMappingsFromDictionary:@{
                                                         @"_id"     : @"id",
                                                         @"user"    : @"user",
                                                         @"title"   : @"title",
                                                         @"body"    : @"body"
                                                         }];
    
    // Update date format so that we can parse Twitter dates properly
    // Wed Sep 29 15:31:08 +0000 2010
    [RKObjectMapping addDefaultDateFormatterForString:@"E MMM d HH:mm:ss Z y" inTimeZone:nil];
    
    // Register our mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptorArticleList = [RKResponseDescriptor
                                                           responseDescriptorWithMapping:articleMapping
                                                           method:RKRequestMethodGET
                                                           pathPattern:[NSString stringWithFormat:@"%@%@",apiVersion,@"/articles"]
                                                           keyPath:@"articles"     // array in {articles:[]}
                                                           statusCodes:[NSIndexSet indexSetWithIndex:200]];
    [objectManager addResponseDescriptor:responseDescriptorArticleList];
    
    
    //    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[Article class] pathPattern:@"/articles/:id" method:RKRequestMethodGET]];
    
    
    RKResponseDescriptor *responseDescriptorArticle = [RKResponseDescriptor
                                                       responseDescriptorWithMapping:articleMapping
                                                       method:RKRequestMethodGET
                                                       pathPattern:[NSString stringWithFormat:@"%@%@",apiVersion,@"/articles/:id"]
                                                       keyPath:nil
                                                       statusCodes:[NSIndexSet indexSetWithIndex:200]];
    [objectManager addResponseDescriptor:responseDescriptorArticle];
    
    
    
    
    // Configure a request mapping for our Article class. We want to send back title, body, and publicationDate
    RKObjectMapping* articleRequestMapping = [RKObjectMapping requestMapping ]; // Shortcut for [RKObjectMapping mappingForClass:[NSMutableDictionary class] ]
    [articleRequestMapping addAttributeMappingsFromArray:@[ @"id",@"title", @"body",@"user" ]];
    RKRequestDescriptor *requestDescriptorArticle = [RKRequestDescriptor requestDescriptorWithMapping:articleRequestMapping objectClass:[Article class] rootKeyPath:nil method:RKRequestMethodAny];
    
    //    RKRequestDescriptor *requestDesscriptorArticle = [RKRequestDescriptor requestDescriptorWithMapping:articleRequestMapping objectClass:[Article class] rootKeyPath:@"/articles" method:RKRequestMethodPOST];
    [objectManager addRequestDescriptor:requestDescriptorArticle];
    
    // work for loadarticle()
    //    [objectManager.router.routeSet addRoute:[RKRoute routeWithName:@"getArticle" pathPattern:@"/articles/:id" method:RKRequestMethodGET]];
    
    // work for loadarticle2()
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[Article class] pathPattern:[NSString stringWithFormat:@"%@%@",apiVersion,@"/articles/:id"] method:RKRequestMethodGET]];
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[Article class] pathPattern:[NSString stringWithFormat:@"%@%@",apiVersion,@"/articles"] method:RKRequestMethodPOST]];
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[Article class] pathPattern:[NSString stringWithFormat:@"%@%@",apiVersion,@"/articles/:id"] method:RKRequestMethodPUT]];
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[Article class] pathPattern:[NSString stringWithFormat:@"%@%@",apiVersion,@"/articles/:id"] method:RKRequestMethodDELETE]];
    
    
    
    /**
     * ERROR Handler
     *
     */
    
    RKObjectMapping *errorMapping = [RKObjectMapping mappingForClass:[RKErrorMessage class]];
    
    [errorMapping addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:nil toKeyPath:@"errorMessage"]];
    
    RKResponseDescriptor *errorDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:errorMapping
                                                                                         method:RKRequestMethodAny
                                                                                    pathPattern:nil
                                                                                        keyPath:@"errors.message"
                                                                                    statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassClientError)];
    
    [objectManager addResponseDescriptor:errorDescriptor];
    //    [objectManager addResponseDescriptorsFromArray:@[errorDescriptor]];
    
    [objectManager.HTTPClient setAuthorizationHeaderWithUsername:@"001+iphone@iphone.com" password:@"appsecret"];
    
}


@end
