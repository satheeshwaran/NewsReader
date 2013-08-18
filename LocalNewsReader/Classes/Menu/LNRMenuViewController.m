//
//  LNRMenuViewController.m
//  LocalNewsReader
//
//  Created by Satheeshwaran on 8/15/13.
//  Copyright (c) 2013 Satheeshwaran. All rights reserved.
//

#import "LNRMenuViewController.h"
#import "LNRBrowseViewController.h"
#import "HorizontalTableCell.h"
#import "ControlVariables.h"

#define kHeadlineSectionHeight  30
#define kRegularSectionHeight   30

@interface LNRMenuViewController ()<FeedTapDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain) NSMutableArray *reusableCells;
@property (nonatomic,retain) NSMutableDictionary *articleDictionary;

@end

@implementation LNRMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.articleDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Articles" ofType:@"plist"]];

    
    if (!self.reusableCells)
    {
        NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES selector:@selector(localizedCompare:)];
        NSArray* sortedCategories = [self.articleDictionary.allKeys sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        
        NSString *categoryName;
        NSArray *currentCategory;
        
        self.reusableCells = [NSMutableArray array];
        
        for (int i = 0; i < [self.articleDictionary.allKeys count]; i++)
        {
            HorizontalTableCell *cell = [[HorizontalTableCell alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
            cell.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
            categoryName = [sortedCategories objectAtIndex:i];
            currentCategory = [self.articleDictionary objectForKey:categoryName];
            cell.articles = [NSArray arrayWithArray:currentCategory];
            
            [self.reusableCells addObject:cell];
        }
    }
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.articleDictionary.allKeys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)? kCellHeight_iPad +20:kCellHeight;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  kRegularSectionHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *customSectionHeaderView;
    UILabel *titleLabel;
    UIFont *labelFont;
    
   
    customSectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, kRegularSectionHeight)] ;
        
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width, kRegularSectionHeight)];
        
    labelFont = [UIFont boldSystemFontOfSize:13];
 
    
    customSectionHeaderView.backgroundColor = [UIColor colorFromHexString:COLOR_BLUE_1];
    
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    titleLabel.font = labelFont;
    
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES selector:@selector(localizedCompare:)];
    NSArray* sortedCategories = [self.articleDictionary.allKeys sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSString *categoryName = [sortedCategories objectAtIndex:section];
    
    titleLabel.text = [categoryName substringFromIndex:1];
    
    [customSectionHeaderView addSubview:titleLabel];
    
    return customSectionHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HorizontalTableCell *cell = [self.reusableCells objectAtIndex:indexPath.section];
    cell.delegate = self;
    
    return cell;
}

-(void)feedSelected:(Feed *)feed {
    
    LNRBrowseViewController *brwseCtrlr = [[LNRBrowseViewController alloc]init];
    [self.navigationController pushViewController:brwseCtrlr animated:YES];
}

#pragma mark - Memory Management

- (void)awakeFromNib
{
    [self.tableView setBackgroundColor:[UIColor colorFromHexString:COLOR_BLUE_1]];
    self.tableView.rowHeight = kCellHeight + (kRowVerticalPadding * 0.5) + ((kRowVerticalPadding * 0.5) * 0.5);
}
@end
