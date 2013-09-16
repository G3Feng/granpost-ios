//
//  articleListCell.m
//  tableApp
//
//  Created by Feng on 2013-09-01.
//  Copyright (c) 2013 GP. All rights reserved.
//

#import "articleListCell.h"

@implementation articleListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:NO animated:YES];
}

-(articleListCell *)setCellWithPost:(NSString *)article atIndex:(NSIndexPath *)indexPath fromController:(UIViewController *)controller {
    if (article) {
        // Set data
        self.titleLabel.text = [article valueForKeyPath:@"title"];
        
//        self.titleLabel.text = post.Title;
//        self.postedTimeLabel.text = [NSString stringWithFormat:@"%@ by %@", [Helpers timeAgoStringForDate:post.TimeCreated], post.Username];
//        self.commentsLabel.text = [NSString stringWithFormat:@"%d", post.CommentCount];
//        self.scoreLabel.text = [NSString stringWithFormat:@"%d Points", post.Points];
//        self.commentTagButton.tag = indexPath.row;
//        self.commentBGButton.tag = indexPath.row;
//        [self.commentTagButton addTarget:controller action:@selector(didClickCommentsFromHomepage:) forControlEvents:UIControlEventTouchUpInside];
//        [self.commentBGButton addTarget:controller action:@selector(didClickCommentsFromHomepage:) forControlEvents:UIControlEventTouchUpInside];
        
        // If PostActions are visible
//        if (post.isOpenForActions) {
//            [Helpers makeShadowForView:self.bottomBar withRadius:0];
//            self.postActionsView.backgroundColor = [[HNSingleton sharedHNSingleton].themeDict objectForKey:@"PostActions"];
//            [self.voteUpButton addTarget:controller action:@selector(voteUp:) forControlEvents:UIControlEventTouchUpInside];
//            [self.voteDownButton addTarget:controller action:@selector(voteDown:) forControlEvents:UIControlEventTouchUpInside];
//            self.voteUpButton.tag = indexPath.row;
//            self.voteDownButton.tag = indexPath.row;
//            
//            if ([HNSingleton sharedHNSingleton].User) {
//                if ([HNSingleton sharedHNSingleton].User.Karma < 500) {
//                    [self.voteDownButton setUserInteractionEnabled:NO];
//                    self.voteDownButton.alpha = 0.3;
//                }
//            }
//            else {
//                [self.voteDownButton setUserInteractionEnabled:NO];
//                self.voteDownButton.alpha = 0.3;
//                [self.voteUpButton setUserInteractionEnabled:NO];
//                self.voteUpButton.alpha = 0.3;
//            }
//        }
        
        // Color cell elements
//        self.titleLabel.textColor = [[HNSingleton sharedHNSingleton].themeDict objectForKey:@"MainFont"];
//        self.postedTimeLabel.textColor = [[HNSingleton sharedHNSingleton].themeDict objectForKey:@"SubFont"];
//        self.scoreLabel.textColor = [[HNSingleton sharedHNSingleton].themeDict objectForKey:@"SubFont"];
//        self.bottomBar.backgroundColor = [[HNSingleton sharedHNSingleton].themeDict objectForKey:@"BottomBar"];
//        [self.commentTagButton setImage:[[HNSingleton sharedHNSingleton].themeDict objectForKey:@"CommentBubble"] forState:UIControlStateNormal];
//        
        // If it's been voted on
//        if ([[HNSingleton sharedHNSingleton] objectIsInVoteDict:post]) {
//            [self.scoreLabel setTextColor:kOrangeColor];
//            self.scoreLabel.alpha = 1;
//            
//            if ([[[[HNSingleton sharedHNSingleton] votedForDictionary] objectForKey:post.PostID] isEqualToString:@"UP"]) {
//                [self.voteUpButton setImage:[UIImage imageNamed:@"voteUpOn-01.png"] forState:UIControlStateNormal];
//                [self.voteUpButton setUserInteractionEnabled:NO];
//                [self.voteDownButton setUserInteractionEnabled:NO];
//            }
//            else {
//                [self.voteDownButton setImage:[UIImage imageNamed:@"voteDownOn-01.png"] forState:UIControlStateNormal];
//                [self.voteUpButton setUserInteractionEnabled:NO];
//                [self.voteDownButton setUserInteractionEnabled:NO];
//            }
//        }
        
        // Show HN Color
//        if (self.titleLabel.text.length >= 9) {
//            if ([[self.titleLabel.text substringWithRange:NSMakeRange(0, 9)] isEqualToString:@"Show HN: "]) {
//                UIView *showHNView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//                showHNView.backgroundColor = [[HNSingleton sharedHNSingleton].themeDict objectForKey:@"ShowHN"];
//                [self insertSubview:showHNView atIndex:0];
//            }
//        }
        
        // Mark as Read
//        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"MarkAsRead"]) {
//            if (post.HasRead) {
//                self.titleLabel.alpha = 0.35;
//            }
//        }
    }
    
    return self;
}


@end
