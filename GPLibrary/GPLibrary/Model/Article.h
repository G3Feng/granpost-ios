//
//  Article.h
//  GPLibrary
//
//  Created by Feng on 2013-09-27.
//  Copyright (c) 2013 GP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSDictionary *user;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *body;
//@property (nonatomic, copy) NSString *image;

@end
