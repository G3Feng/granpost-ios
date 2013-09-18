//
//  ViewController.m
//  tableApp
//
//  Created by Feng on 2013-09-01.
//  Copyright (c) 2013 GP. All rights reserved.
//

#import "TBViewController.h"
#import "ServerLink.h"

@interface TBViewController () {
    __weak IBOutlet UITableView *articleTable;
    NSMutableArray *articlesList;
}

@end

@implementation TBViewController
//@synthesize articleTable;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self loadArticleTable];
    
    [self buildUI];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)buildUI
{
    NSLog(@"start buildUI ==>");
    articleTable.frame = CGRectMake(0, 0, articleTable.frame.size.width, articleTable.frame.size.height);
    
}

-(void)loadArticleTable
{
    NSLog(@"start loadArticleTable ==>");
//    articlesList = @[@"Hello,everyone",@"Welcome to new users",@"This program is created"];
    articlesList = [[ServerLink instance]articleList];

    [articleTable reloadData];
}



#pragma mark - TableView Delegate
-(int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == articleTable) {
        return articlesList.count;
    }
    else {
        return 1;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"tableView heightForRowAtIndexPath = %@",indexPath);

    // Comment Cell Height

    if ([articlesList objectAtIndex:indexPath.row]) {
        return kFrontPageActionsHeight;
    }
    return kFrontPageCellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    NSLog(@"tableView = %@",tableView);
    
    NSString *CellIdentifier = @"articleListCell";
    articleListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"GPResource" withExtension:@"bundle"]];
        NSLog(@"|cell| load bundle:%@",bundle);
        NSArray* views = [bundle loadNibNamed:@"articleListCell" owner:nil options:nil];
//        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"articleListCell" owner:nil options:nil];
        
        for (UIView *view in views) {
            if([view isKindOfClass:[UITableViewCell class]]) {
                cell = (articleListCell *)view;
            }
        }
    }
    
    cell = [cell setCellWithPost:articlesList[indexPath.row] atIndex:indexPath fromController:self];
    
    NSLog(@"|ViewController tableView| set cell %@",articlesList[indexPath.row]);
    return cell;

}



- (void)viewDidUnload {
    articleTable = nil;
    [super viewDidUnload];
}
@end
