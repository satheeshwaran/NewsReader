//
//  HorizontalTableCell.m
//  HorizontalTables
//
//  Created by Felipe Laso on 8/19/11.
//  Copyright 2011 Felipe Laso. All rights reserved.
//

#import "HorizontalTableCell.h"
#import "ArticleCell.h"
#import "ControlVariables.h"



@implementation HorizontalTableCell

@synthesize horizontalTableView = _horizontalTableView;
@synthesize articles = _articles;

#pragma mark - Table View Data Source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.articles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ArticleCell";
    
    __block ArticleCell *cell = (ArticleCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        cell = [[ArticleCell alloc] initWithFrame:CGRectMake(0, 0, kCellWidth, kCellHeight)] ;
        else
        cell = [[ArticleCell alloc] initWithFrame:CGRectMake(0, 0, kTableLength_iPad,kCellHeight_iPad )] ;
    }
    
    __block NSDictionary *currentArticle = [self.articles objectAtIndex:indexPath.row];
    
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(concurrentQueue, ^{
        UIImage *image = nil;
        image = [UIImage imageNamed:[currentArticle objectForKey:@"ImageName"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell.thumbnail setImage:image];
        });
    });
    
    
    return cell;
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        self.horizontalTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kCellHeight, kTableLength)] ;
        
        else
            self.horizontalTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kCellHeight_iPad, kTableLength_iPad)] ;

        self.horizontalTableView.showsVerticalScrollIndicator = NO;
        self.horizontalTableView.showsHorizontalScrollIndicator = NO;
        self.horizontalTableView.transform = CGAffineTransformMakeRotation(-M_PI * 0.5);
        
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        [self.horizontalTableView setFrame:CGRectMake(kRowHorizontalPadding * 0.5, kRowVerticalPadding * 0.5, kTableLength - kRowHorizontalPadding, kCellHeight)];
        
        else
        [self.horizontalTableView setFrame:CGRectMake(kRowHorizontalPadding_iPad * 0.5, kRowVerticalPadding_iPad * 0.5, kTableLength_iPad - kRowHorizontalPadding_iPad, kCellHeight_iPad+20)];
        
        self.horizontalTableView.rowHeight = kCellWidth;
        self.horizontalTableView.backgroundColor = [UIColor colorFromHexString:@"FFFFFF"];
        
        self.horizontalTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.horizontalTableView.separatorColor = [UIColor clearColor];
        
        self.horizontalTableView.dataSource = self;
        self.horizontalTableView.delegate = self;
        [self addSubview:self.horizontalTableView];
        

    }
    
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)? 140 :ARTICLE_TABLE_ROW_HEIGHT_IPHONE;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.delegate feedSelected:nil];
}

#pragma mark - Memory Management

- (NSString *) reuseIdentifier 
{
    return @"HorizontalCell";
}

- (void)dealloc
{
    self.horizontalTableView = nil;
    self.articles = nil;
    
}

@end
