//
//  ViewController.m
//  tableApp
//
//  Created by Feng on 2013-09-01.
//  Copyright (c) 2013 GP. All rights reserved.
//

#import "TBViewController.h"
#import "ServerLink.h"

#import "articleListCell.h"
#import "CommentsCell.h"
#import "StyleManager.h"

@interface TBViewController () {
    __weak IBOutlet UITableView *articleTable;
    __weak IBOutlet UITableView *commentsTable;
    __weak IBOutlet UINavigationBar *commentsHeader;
    IBOutlet UIView *commentsView;
    
    NSMutableArray *articlesList;
    
    NSMutableDictionary *currentArticle;
    
    NSArray *organizedCommentsArray;
}

@end

@implementation TBViewController
//@synthesize articleTable;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // warm trick, force linker to keep the whole class
//    [articleListCell class];
    
    [self loadArticleTable];
    [self buildUI];
    
    [self setScrollViewToScrollToTop:articleTable];
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)buildUI
{
    NSLog(@"start buildUI ...");
    articleTable.frame = CGRectMake(0, 0, articleTable.frame.size.width, articleTable.frame.size.height);

    [StyleManager changeTheme];    
    [self colorUI];
}

-(void)colorUI {
    // Set Colors for all objects based on Theme
    self.view.backgroundColor = [[StyleManager getTheme] objectForKey:@"CellBG"];
//    NSLog(@"|colorUI| mode : %@",[[StyleManager getTheme] objectForKey:@"Mode"]);
    articleTable.backgroundColor = [[StyleManager getTheme] objectForKey:@"CellBG"];
    articleTable.separatorColor = [[StyleManager getTheme] objectForKey:@"Separator"];
    
    commentsTable.backgroundColor = [[StyleManager getTheme] objectForKey:@"CellBG"];
//    underHeaderTriangle.backgroundColor = [[HNSingleton sharedHNSingleton].themeDict objectForKey:@"TableTriangle"];
//    headerTriangle.color = [[HNSingleton sharedHNSingleton].themeDict objectForKey:@"TableTriangle"];
//    [headerTriangle drawTriangleAtXPosition:self.view.frame.size.width/2];
    
    // Redraw View
    [self.view setNeedsDisplay];
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
//        return 1;
        NSArray *comments = [currentArticle objectForKey:@"comments"];
        return comments.count;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    
//    NSLog(@"tableView heightForRowAtIndexPath = %@",indexPath);
//
//    // Comment Cell Height
//
//    if ([articlesList objectAtIndex:indexPath.row]) {
//        return kFrontPageActionsHeight;
//    }
//    return kFrontPageCellHeight;
    
    
    // Comment Cell Height
    if (tableView == commentsTable) {
        NSLog(@"comment height");
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell %d", indexPath.row];
        CommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"GPResource" withExtension:@"bundle"]];
            if(![bundle isLoaded]) {
                [bundle load];
                NSLog(@"bundle loaded.");
            }
//            NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"CommentsCell" owner:nil options:nil];
            NSArray* views = [bundle loadNibNamed:@"CommentsCell" owner:nil options:nil];
            for (UIView *view in views) {
                if([view isKindOfClass:[UITableViewCell class]]) {
                    cell = (CommentsCell *)view;
                }
            }
        }
        
        Comment *comment = [[Comment alloc] init];
        comment.Text = [[currentArticle objectForKey:@"comments"][indexPath.row] objectForKey:@"body"];
        comment.Username = [[currentArticle objectForKey:@"comments"][indexPath.row] objectForKey:@"user"];
        
        NSLog(@"|cell| comment.Text=%@",comment.Text);
        NSLog(@"|cell| comment.Username=%@",comment.Username);

        
//        return [cell heightForComment:(organizedCommentsArray.count > 0 ? organizedCommentsArray[indexPath.row] : nil)];
        return [cell heightForComment:comment];
        
        
    }
    
    // Article Cell Height
    else {
        NSLog(@"article height");
        if ([articlesList objectAtIndex:indexPath.row]) {
            return kFrontPageActionsHeight;
        }
        return kFrontPageCellHeight;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *className = NSStringFromClass([tableView class]);
//    NSLog(@"tableView class name : %@",className);
    NSLog(@"articleTable? %@",(tableView == articleTable ? @"Yes" : @"No"));
    NSLog(@"commentsTable? %@",(tableView == commentsTable ? @"Yes" : @"No"));
    
    // Article Cell
    if (tableView == articleTable) {
        NSLog(@"|tableView| -> article cell");
        NSString *CellIdentifier = @"articleListCell";
        articleListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"GPResource" withExtension:@"bundle"]];
//            NSLog(@"|cell| load bundle:%@",bundle);
            if(![bundle isLoaded]) {
                [bundle load];
                NSLog(@"bundle loaded.");
            }
            NSArray* views = [bundle loadNibNamed:@"articleListCell" owner:nil options:nil];
            //        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"articleListCell" owner:nil options:nil];
            
            for (UIView *view in views) {
                if([view isKindOfClass:[UITableViewCell class]]) {
                    cell = (articleListCell *)view;
                }
            }
        }
        
        cell = [cell setCellWithPost:articlesList[indexPath.row] atIndex:indexPath fromController:self];
        return cell;
        
    }
    
    
    // Comments Cell
    else {
        NSLog(@"|tableView| -> comments cell");
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell %d", indexPath.row];
        CommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"GPResource" withExtension:@"bundle"]];
            if(![bundle isLoaded]) {
                [bundle load];
                NSLog(@"bundle loaded.");
            }

//            NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"CommentsCell" owner:nil options:nil];
            NSArray* views = [bundle loadNibNamed:@"CommentsCell" owner:nil options:nil];
            for (UIView *view in views) {
                if([view isKindOfClass:[UITableViewCell class]]) {
                    cell = (CommentsCell *)view;
                }
            }
        }
//        cell = [cell cellForComment:(organizedCommentsArray.count > 0 ? organizedCommentsArray[indexPath.row] : nil) atIndex:indexPath fromController:self];

        Comment *comment = [[Comment alloc] init];
        comment.Text = [[currentArticle objectForKey:@"comments"][indexPath.row] objectForKey:@"body"];
        comment.Username = [[currentArticle objectForKey:@"comments"][indexPath.row] objectForKey:@"user"];
        
        NSLog(@"|cell| comment.Text=%@",comment.Text);
        NSLog(@"|cell| comment.Username=%@",comment.Username);
        
        cell = [cell cellForComment:comment atIndex:indexPath fromController:self];
        
        
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == articleTable) {
        // Set Current Post
        currentArticle = articlesList[indexPath.row];
        
        
        // Mark As Read
//        currentPost.HasRead = YES;
//        [[HNSingleton sharedHNSingleton].hasReadThisArticleDict setValue:@"YES" forKey:currentPost.PostID];
        
        // Launch LinkView
//        [self launchLinkView];
        
        [commentsTable reloadData];
        [self launchCommentsView];
        
        // Reload table so Mark As Read will show up
//        [articleTable reloadData];
        
        // Show header if it's offscreen
//        [UIView animateWithDuration:0.25 animations:^{
//            [self placeHeaderBarBack];
//        }];
    }
}

-(void)launchCommentsView {
    // Scroll to Top
//    [commentsTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    // Set Post-Title Label
//    postTitleLabel.text = currentPost.Title;
    NSLog(@"|launchCommentsView| currentArticle:%@",[currentArticle objectForKey:@"title"]);
    
    // Set frames
//    commentsView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height - headerContainer.frame.size.height - 20);
    commentsView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height - 20);
    
    commentsHeader.frame = CGRectMake(0, 0, commentsHeader.frame.size.width, commentsHeader.frame.size.height);
    commentsTable.frame = CGRectMake(0, commentsHeader.frame.size.height, commentsView.frame.size.width, commentsView.frame.size.height - commentsHeader.frame.size.height);
    
    // Add to self.view
    [self.view addSubview:commentsView];
    [self.view bringSubviewToFront:commentsView];
    
    
    // Animate everything
    [UIView animateWithDuration:0.3 animations:^{
        [articleTable setScrollEnabled:NO];
        [articleTable setContentOffset:articleTable.contentOffset animated:NO];
//        headerContainer.frame = CGRectMake(0, 0, headerContainer.frame.size.width, headerContainer.frame.size.height);
//        commentsView.frame = CGRectMake(0, headerContainer.frame.size.height, commentsView.frame.size.width, [UIScreen mainScreen].bounds.size.height - headerContainer.frame.size.height - 20);
        commentsView.frame = CGRectMake(0, 0, commentsView.frame.size.width, [UIScreen mainScreen].bounds.size.height - 20);
        
    } completion:^(BOOL fin){
        [articleTable setScrollEnabled:YES];
    }];
    
    [self setScrollViewToScrollToTop:commentsTable];
}

#pragma mark ScrollToTop Management
-(void)setScrollViewToScrollToTop:(UIScrollView*)scrollView{
    commentsTable.scrollsToTop = NO;
    articleTable.scrollsToTop = NO;
    
    scrollView.scrollsToTop = YES;
}

- (void)viewDidUnload {
    articleTable = nil;
    [super viewDidUnload];
}
@end
