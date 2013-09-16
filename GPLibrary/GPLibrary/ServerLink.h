//
//  ServerLink.h
//  tableApp
//
//  Created by Feng on 2013-09-02.
//  Copyright (c) 2013 GP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerLink : NSObject

@property (nonatomic,retain) NSMutableArray* articleList;

+(ServerLink*)instance;

@end
