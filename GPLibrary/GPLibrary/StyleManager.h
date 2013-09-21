//
//  StyleManager.h
//  GPLibrary
//
//  Created by Feng on 2013-09-21.
//  Copyright (c) 2013 GP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StyleManager : NSObject

+(void)changeTheme;
+(NSMutableDictionary*)getTheme;
@end
