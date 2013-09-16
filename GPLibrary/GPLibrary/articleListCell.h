//
//  articleListCell.h
//  tableApp
//
//  Created by Feng on 2013-09-01.
//  Copyright (c) 2013 GP. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kFrontPageCellHeight 96
#define kFrontPageActionsHeight 148

@interface articleListCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;

@property (retain, nonatomic) IBOutlet UILabel *postedTimeLabel;
@property (retain, nonatomic) IBOutlet UILabel *scoreLabel;
@property (retain, nonatomic) IBOutlet UILabel *commentsLabel;
@property (retain, nonatomic) IBOutlet UILabel *authorLabel;
@property (retain, nonatomic) IBOutlet UIButton *commentTagButton;
@property (retain, nonatomic) IBOutlet UIButton *commentBGButton;
@property (retain, nonatomic) IBOutlet UIImageView *bottomBar;
//@property (weak, nonatomic) IBOutlet UIButton *voteUpButton;
//@property (weak, nonatomic) IBOutlet UIButton *voteDownButton;
@property (weak, nonatomic) IBOutlet UIView *postActionsView;


-(articleListCell *)setCellWithPost:(NSString *)article atIndex:(NSIndexPath *)indexPath fromController:(UIViewController *)controller;
@end
