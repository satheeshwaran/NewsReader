//
//  ArticleCell.h
//  HorizontalTables
//
//  Created by Felipe Laso on 8/20/11.
//  Copyright 2011 Felipe Laso. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ArticleCell : UITableViewCell 
{
    UIImageView *_thumbnail;
}

@property (nonatomic, retain) UIImageView *thumbnail;

@end
