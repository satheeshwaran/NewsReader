//
//  ContentView.m
//  Layouts
//
//  Created by Manikandan K on 15/03/13.
//  Copyright (c) 2013 Cognizant. All rights reserved.
//

#import "ContentView.h"
#import "Article.h"
#import "Utils.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation ContentView
@synthesize delegate;
@synthesize contentImageView;

- (id)initWithArticle:(Article *)article
{
    self = [super init];
    if (self) {
        // Initialization code
        self.article=article;
        [self initializeFields];
        UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
		[self addGestureRecognizer:tapRecognizer];
    }
    return self;
}

- (void) initializeFields {
    
    contentView = [[UIView alloc] init];
	[contentView setBackgroundColor:[UIColor clearColor]];
	contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:contentView];
    
    self.contentImageView = [[UIImageView alloc]init];
    self.contentImageView.image = [UIImage imageWithData:self.article.articleImageData];
    self.contentImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.contentImageView.clipsToBounds = YES;
    [self addSubview:self.contentImageView];
    
    contentSource = [[UILabel alloc]init];
    [contentSource setBackgroundColor:[UIColor clearColor]];
    [contentSource sizeToFit];
    
   
    contentSource.text = [NSString stringWithFormat:@"Apple News | A Few mins ago"];
    [contentSource setTextColor:[UIColor lightGrayColor]];
    contentSource.textAlignment = NSTextAlignmentLeft;
    contentSource.lineBreakMode=NSLineBreakByWordWrapping;
    contentSource.numberOfLines=1;
    [contentSource setFont:[UIFont boldSystemFontOfSize:12.0]];
    [contentView addSubview:contentSource];
    
    contentTitle = [[UILabel alloc]init];
    [contentTitle setBackgroundColor:[UIColor clearColor]];
    [contentTitle sizeToFit];
    contentTitle.text =self.article.articleName;
    [contentTitle setTextColor:[UIColor blackColor]];
    contentTitle.textAlignment = NSTextAlignmentLeft;
    contentTitle.lineBreakMode=NSLineBreakByWordWrapping;
    [contentTitle setFont:[UIFont boldSystemFontOfSize:20.0]];
    [contentView addSubview:contentTitle];
    
    contentDescription = [[UILabel alloc]init];
    [contentDescription setBackgroundColor:[UIColor clearColor]];
    if (self.article.articleContent.length>self.article.articleDescription.length)
        contentDescription.text=[self stripTags:self.article.articleContent];
    else
        contentDescription.text=[self stripTags:self.article.articleDescription];
    
    [contentDescription setTextColor:UIColorFromRGB(0x090909)];
    contentDescription.textAlignment = NSTextAlignmentLeft;
    contentDescription.lineBreakMode=NSLineBreakByWordWrapping;
    [contentDescription setFont:[UIFont systemFontOfSize:16.0]];
    [contentView addSubview:contentDescription];
    
    [self reAdjustLayout];
    
}

- (NSString *)stripTags:(NSString *)str
{
    NSMutableString *html = [NSMutableString stringWithCapacity:[str length]];
    
    NSScanner *scanner = [NSScanner scannerWithString:str];
    scanner.charactersToBeSkipped = NULL;
    NSString *tempText = nil;
    
    while (![scanner isAtEnd])
    {
        [scanner scanUpToString:@"<" intoString:&tempText];
        
        if (tempText != nil)
            [html appendString:tempText];
        
        [scanner scanUpToString:@">" intoString:NULL];
        
        if (![scanner isAtEnd])
            [scanner setScanLocation:[scanner scanLocation] + 1];
        
        tempText = nil;
    }
    
    return html;
}

- (void)reAdjustLayout {
    [contentView setFrame:CGRectMake(1, 1, self.frame.size.width-1, self.frame.size.height - 2)];
	CGSize contentViewArea = CGSizeMake(contentView.frame.size.width, contentView.frame.size.height);
    
   if(!self.article.isArticleImageAvailable) {
        
        [contentTitle setFrame:CGRectMake(contentView.frame.origin.x + 15, contentView.frame.origin.y, contentView.frame.size.width -20, contentView.frame.size.height)];
        [self setLabelHeightAndLines:contentTitle withSize:20.0];
        
        [contentSource setFrame:CGRectMake(contentView.frame.origin.x +15, contentTitle.frame.origin.y+contentTitle.frame.size.height +10, contentView.frame.size.width -10, 20)];
        
        [contentDescription setFrame:CGRectMake(contentView.frame.origin.x +15, contentTitle.frame.origin.y+contentTitle.frame.size.height +35, contentView.frame.size.width -20, contentView.frame.size.height-contentTitle.frame.size.height-50)];
        [self setLabelHeightAndLines:contentDescription withSize:16.0];
        
    }
    else { 
        if(contentViewArea.width>600)
        {
            
            [self.contentImageView setFrame:CGRectMake(contentView.frame.origin.x + 15, contentView.frame.origin.y +10, 350, contentView.frame.size.height - 20)];
            
            [contentTitle setFrame:CGRectMake(self.contentImageView.frame.origin.x + self.contentImageView.frame.size.width + 10, contentView.frame.origin.y +10, contentView.frame.size.width - self.contentImageView.frame.size.width  -30, contentView.frame.size.height)];
            [self setLabelHeightAndLines:contentTitle withSize:20.0];
            
            [contentSource setFrame:CGRectMake(self.contentImageView.frame.origin.x + self.contentImageView.frame.size.width + 10, contentTitle.frame.origin.y+contentTitle.frame.size.height +10, contentView.frame.size.width - self.contentImageView.frame.size.width-25, 20)];
            
            [contentDescription setFrame:CGRectMake(self.contentImageView.frame.origin.x + self.contentImageView.frame.size.width + 10, contentTitle.frame.origin.y+contentTitle.frame.size.height +35, contentView.frame.size.width - self.contentImageView.frame.size.width -30, contentView.frame.size.height-contentTitle.frame.size.height-70)];
            [self setLabelHeightAndLines:contentDescription withSize:16.0];
        }
        else if(contentViewArea.width<350 && contentViewArea.height>350)
        {
            
           [self.contentImageView setFrame:CGRectMake(contentView.frame.origin.x + 15, contentView.frame.origin.y +10, contentView.frame.size.width -30, 150)];
            
            [contentTitle setFrame:CGRectMake(contentView.frame.origin.x + 15, self.contentImageView.frame.origin.y+self.contentImageView.frame.size.height + 10, contentView.frame.size.width -25, contentView.frame.size.height)];
            [self setLabelHeightAndLines:contentTitle withSize:20.0];
            
            [contentSource setFrame:CGRectMake(contentView.frame.origin.x +15, contentTitle.frame.origin.y+contentTitle.frame.size.height +10, contentView.frame.size.width -25, 20)];
            
            [contentDescription setFrame:CGRectMake(contentView.frame.origin.x +15, contentTitle.frame.origin.y+contentTitle.frame.size.height +35, contentView.frame.size.width -20, contentView.frame.size.height-contentTitle.frame.size.height-self.contentImageView.frame.size.height-70)];
            [self setLabelHeightAndLines:contentDescription withSize:16.0];
        }
        else if(contentViewArea.width<400 && contentViewArea.height<350)
        {
            
            [self.contentImageView setFrame:CGRectMake(contentView.frame.origin.x + 15, contentView.frame.origin.y +10, 140, contentView.frame.size.height - 20)];
            
            [contentTitle setFrame:CGRectMake(self.contentImageView.frame.origin.x + self.contentImageView.frame.size.width + 10, contentView.frame.origin.y +10, contentView.frame.size.width - self.contentImageView.frame.size.width  -30, contentView.frame.size.height)];
            [self setLabelHeightAndLines:contentTitle withSize:20.0];
            
            [contentSource setFrame:CGRectMake(self.contentImageView.frame.origin.x + self.contentImageView.frame.size.width + 10, contentTitle.frame.origin.y+contentTitle.frame.size.height +10, contentView.frame.size.width - self.contentImageView.frame.size.width-25, 20)];
            
            [contentDescription setFrame:CGRectMake(self.contentImageView.frame.origin.x + self.contentImageView.frame.size.width + 10, contentTitle.frame.origin.y+contentTitle.frame.size.height +35, contentView.frame.size.width - self.contentImageView.frame.size.width -30, contentView.frame.size.height-contentTitle.frame.size.height-70)];
            [self setLabelHeightAndLines:contentDescription withSize:16.0];
        }
        else if (contentViewArea.width>400 && contentViewArea.height<350) {
            
            [self.contentImageView setFrame:CGRectMake(contentView.frame.origin.x + 15, contentView.frame.origin.y +10, 200, contentView.frame.size.height - 20)];
            
            [contentTitle setFrame:CGRectMake(self.contentImageView.frame.origin.x + self.contentImageView.frame.size.width + 10, contentView.frame.origin.y +10, contentView.frame.size.width - self.contentImageView.frame.size.width  -30, contentView.frame.size.height)];
            [self setLabelHeightAndLines:contentTitle withSize:20.0];
            
            [contentSource setFrame:CGRectMake(self.contentImageView.frame.origin.x + self.contentImageView.frame.size.width + 10, contentTitle.frame.origin.y+contentTitle.frame.size.height +10, contentView.frame.size.width - self.contentImageView.frame.size.width-25, 20)];
            
            [contentDescription setFrame:CGRectMake(self.contentImageView.frame.origin.x + self.contentImageView.frame.size.width + 10, contentTitle.frame.origin.y+contentTitle.frame.size.height +35, contentView.frame.size.width - self.contentImageView.frame.size.width -30, contentView.frame.size.height-contentTitle.frame.size.height-70)];
            [self setLabelHeightAndLines:contentDescription withSize:16.0];
        }
        else if (contentViewArea.width>350 && contentViewArea.height>350) {
            [self.contentImageView setFrame:CGRectMake(contentView.frame.origin.x + 15, contentView.frame.origin.y +10, contentView.frame.size.width -30, 150)];
            
            [contentTitle setFrame:CGRectMake(contentView.frame.origin.x + 15, self.contentImageView.frame.origin.y+self.contentImageView.frame.size.height + 10, contentView.frame.size.width -25, contentView.frame.size.height)];
            [self setLabelHeightAndLines:contentTitle withSize:20.0];
            
            [contentSource setFrame:CGRectMake(contentView.frame.origin.x +15, contentTitle.frame.origin.y+contentTitle.frame.size.height +10, contentView.frame.size.width -25, 20)];
            
            [contentDescription setFrame:CGRectMake(contentView.frame.origin.x +15, contentTitle.frame.origin.y+contentTitle.frame.size.height +35, contentView.frame.size.width -20, contentView.frame.size.height-contentTitle.frame.size.height-self.contentImageView.frame.size.height-70)];
            [self setLabelHeightAndLines:contentDescription withSize:16.0];
        }
        else {
            [contentView setBackgroundColor:[UIColor clearColor]];
        }
   }
}


-(void)setLabelHeightAndLines:(UILabel *)label withSize:(CGFloat)size
{
    CGSize labelSize = [label.text sizeWithFont:label.font
                                constrainedToSize:label.frame.size
                                    lineBreakMode:NSLineBreakByWordWrapping];
    CGRect labelFrame = label.frame;
    labelFrame.size.height = labelSize.height;
    label.frame = labelFrame;
    
    int lines = [label.text sizeWithFont:label.font
                       constrainedToSize:label.frame.size
                           lineBreakMode:NSLineBreakByWordWrapping].height /size;
    label.numberOfLines = lines;
}


-(void)tapped:(UITapGestureRecognizer *)recognizer {
    if ([self.delegate respondsToSelector:@selector(showViewInFullScreen:withArticle:)])
    {
        [self.delegate showViewInFullScreen:self withArticle:_article];
    }
    
}

-(void) setFrame:(CGRect)rect {
    self.originalRect = rect;
    [super setFrame:rect];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
