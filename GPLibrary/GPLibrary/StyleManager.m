//
//  StyleManager.m
//  GPLibrary
//
//  Created by Feng on 2013-09-21.
//  Copyright (c) 2013 GP. All rights reserved.
//

#import "StyleManager.h"

static NSMutableDictionary *themeDict;
@implementation StyleManager

+(void)changeTheme
{
    themeDict = [@{} mutableCopy];
    int mode = 2;
    if (1==mode){
        [themeDict setValue:@"mode1" forKey:@"Mode"];
        [themeDict setValue:[UIColor colorWithWhite:0.2 alpha:1.0] forKey:@"CellBG"];
        [themeDict setValue:[UIColor colorWithWhite:0.92 alpha:1.0] forKey:@"MainFont"];
        [themeDict setValue:[UIColor colorWithWhite:0.98 alpha:1.0] forKey:@"SubFont"];
        [themeDict setValue:[UIColor colorWithWhite:0.25 alpha:1.0] forKey:@"BottomBar"];
        [themeDict setValue:[UIColor colorWithWhite:0.33 alpha:1.0] forKey:@"Separator"];
        [themeDict setValue:[UIColor colorWithWhite:0.17 alpha:1.0] forKey:@"TableTriangle"];
        [themeDict setValue:[UIImage imageNamed:@"commentbubble-01.png"] forKey:@"CommentBubble"];
        [themeDict setValue:[UIColor colorWithRed:53/255.0 green:77/255.0 blue:93/255.0 alpha:1.0] forKey:@"ShowHN"];
        [themeDict setValue:[UIColor colorWithRed:47/255.0 green:93/255.0 blue:54/255.0 alpha:1.0] forKey:@"HNJobs"];
        [themeDict setValue:[UIColor colorWithRed:44/255.0 green:44/255.0 blue:44/255.0 alpha:1.0] forKey:@"PostActions"];
    } else {
        [themeDict setValue:@"mode2" forKey:@"Mode"];
        [themeDict setValue:[UIColor colorWithWhite:0.85 alpha:1.0] forKey:@"CellBG"];
        [themeDict setValue:[UIColor colorWithWhite:0.4 alpha:1.0] forKey:@"MainFont"];
        [themeDict setValue:[UIColor colorWithWhite:0.20 alpha:1.0] forKey:@"SubFont"];
        [themeDict setValue:[UIColor colorWithWhite:0.75 alpha:1.0] forKey:@"BottomBar"];
        [themeDict setValue:[UIColor colorWithWhite:0.70 alpha:1.0] forKey:@"Separator"];
        [themeDict setValue:[UIColor colorWithWhite:0.89 alpha:1.0] forKey:@"TableTriangle"];
        [themeDict setValue:[UIImage imageNamed:@"commentbubbleDark.png"] forKey:@"CommentBubble"];
        [themeDict setValue:[UIColor colorWithRed:183/255.0 green:211/255.0 blue:235/255.0 alpha:1.0] forKey:@"ShowHN"];
        [themeDict setValue:[UIColor colorWithRed:170/255.0 green:235/255.0 blue:185/255.0 alpha:1.0] forKey:@"HNJobs"];
        [themeDict setValue:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0] forKey:@"PostActions"];
    }
    NSLog(@"|StyleManager| mode : %@", [themeDict objectForKey:@"Mode"]);
}

+(NSMutableDictionary*)getTheme
{
    return themeDict;
}


@end
