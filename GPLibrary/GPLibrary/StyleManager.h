//
//  StyleManager.h
//  GPLibrary
//
//  Created by Feng on 2013-09-21.
//  Copyright (c) 2013 GP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kPad 10

@interface StyleManager : NSObject

+(void)changeTheme;
+(NSMutableDictionary*)getTheme;
@end
