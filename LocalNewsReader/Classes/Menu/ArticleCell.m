//
//  ArticleCell.m
//  HorizontalTables
//
//  Created by Felipe Laso on 8/20/11.
//  Copyright 2011 Felipe Laso. All rights reserved.
//

#import "ArticleCell.h"
#import "ControlVariables.h"
#import "UIColor+Additions.h"

@implementation ArticleCell

@synthesize thumbnail = _thumbnail;

#pragma mark - View Lifecycle

- (NSString *)reuseIdentifier 
{
    return @"ArticleCell";
}

#pragma mark - Memory Management

- (void)dealloc
{
    self.thumbnail = nil;
    
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    self.thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(ARTICLE_CELL_X_ORIGIN_IPHONE, ARTICEL_CELL_Y_ORIGIN_IPHONE, ARTICLE_CELL_WIDTH_IPHONE,ARTICEL_CELL_HEIGHT_IPHONE)] ;
    
    else
        self.thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(ARTICLE_CELL_X_ORIGIN_IPAD, ARTICEL_CELL_Y_ORIGIN_IPAD, ARTICLE_CELL_WIDTH_IPAD,ARTICEL_CELL_HEIGHT_IPAD)] ;
    
    
    self.thumbnail.opaque = YES;
    [self.contentView addSubview:self.thumbnail];
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0.40784314 blue:0.21568627 alpha:1.0];
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.thumbnail.frame] ;
    //self.selectedBackgroundView.backgroundColor = [UIColor colorFromHexString:@"388E82"];
    
    self.transform = CGAffineTransformMakeRotation(M_PI * 0.5);
    
    return self;
}


@end
