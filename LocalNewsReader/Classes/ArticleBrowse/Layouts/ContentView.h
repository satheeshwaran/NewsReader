//
//  ContentView.h
//  Layouts
//
//  Created by Manikandan K on 15/03/13.
//  Copyright (c) 2013 Cognizant. All rights reserved.
//

#import "UIViewExtention.h"
@class Article;

@protocol TapDelegate<NSObject>
@optional
-(void)showViewInFullScreen:(UIViewExtention *)viewToShow withArticle:(Article *)article;
@end

@interface ContentView : UIViewExtention {
    
    UIView *contentView;
    UIImageView *contentImageView;
    UILabel *contentSource;
    UILabel *contentTitle;
    UILabel *contentDescription;
}

@property (nonatomic, assign) NSObject<TapDelegate> *delegate;
@property (nonatomic, strong) Article *article;
@property (nonatomic, strong) UIImageView *contentImageView;

- (id)initWithArticle:(Article *)article;
- (void) initializeFields;
- (void) reAdjustLayout;

@end
