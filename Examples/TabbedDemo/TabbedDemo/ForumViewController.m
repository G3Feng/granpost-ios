//
//  ForumViewController.m
//  TabbedDemo
//
//  Created by Feng on 2013-09-15.
//  Copyright (c) 2013 GP. All rights reserved.
//

/*
    
     add the "-all_load -ObjC" flags to the "Other Linker Flags" key , to solve error "Unknown class articleListCell in Interface Builder file."
 
 
 
 */
 





#import "ForumViewController.h"

@interface ForumViewController ()

@end

@implementation ForumViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

//- (id)init {
//    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"GPResource" withExtension:@"bundle"]];
//    if ((self = [super initWithNibName:@"TBViewController" bundle:bundle])) {
//    }
//    return self;
//}

- (void)loadView
{
    NSLog(@"loadView");
//    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"TBViewController" owner:self options:nil];
    
    
    
    
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"GPResource" withExtension:@"bundle"]];
    NSLog(@"bundle: %@",bundle);
    
    if(![bundle isLoaded]) {
        [bundle load];
        NSLog(@"bundle loaded.");
    }
    
    NSArray *views = [bundle loadNibNamed:@"TBViewController" owner:self options:nil];
    self.view = [views objectAtIndex:0];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"Forum view loaded.");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
