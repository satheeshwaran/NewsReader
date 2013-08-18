//
//  HorizontalTableCell.h
//  HorizontalTables
//
//  Created by Felipe Laso on 8/19/11.
//  Copyright 2011 Felipe Laso. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Feed.h"

@protocol FeedTapDelegate <NSObject>

-(void)feedSelected:(Feed *)feed;

@end

@interface HorizontalTableCell : UITableViewCell <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_horizontalTableView;
    NSArray *_articles;
}

@property (nonatomic, assign) id <FeedTapDelegate> delegate;
@property (nonatomic, retain) UITableView *horizontalTableView;
@property (nonatomic, retain) NSArray *articles;

@end
