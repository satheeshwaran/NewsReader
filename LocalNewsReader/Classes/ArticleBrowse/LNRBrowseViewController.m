//
//  LNRBrowseViewController.m
//  LocalNewsReader
//
//  Created by Admin on 8/18/13.
//  Copyright (c) 2013 Satheeshwaran. All rights reserved.
//

#import "LNRBrowseViewController.h"
#import "LayoutsGenerator.h"
#import "LayoutViewExtention.h"
#import "ContentView.h"
#import "CoreDataHelper.h"
#import "LNRUtils.h"
#import "Article.h"
#import "LNRTransport.h"

@interface LNRBrowseViewController ()<UIScrollViewDelegate,TapDelegate>

@property (nonatomic) int numberOfPages;
@property (nonatomic) int currentPage;
@property (nonatomic) int startIndex;
@property (nonatomic) UIInterfaceOrientation deviceOrientation;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong) NSArray *layoutsAsCombinations;
@property (nonatomic,strong) NSMutableArray *articles;

@end

@implementation LNRBrowseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.articles = [NSMutableArray new];
    self.deviceOrientation = self.interfaceOrientation;
    [self fetchFeed];
}

-(void)fetchFeed {
    
    LNRTransport *feedTrans = [[LNRTransport alloc]initWithURL:[NSURL URLWithString:FEED_URL] andWithDetails:nil];
    [feedTrans makeHTTPRequest];
    [feedTrans setCompletionHandler:^(NSData *responseData, int status) {
        
        NSError *error;
        NSDictionary *sourceDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
        NSArray *feedArticles = [[sourceDict objectForKey:@"value"]objectForKey:@"items"];
        for (NSDictionary *dict in feedArticles) {
            if (![[CoreDataHelper sharedInstance] checkAttributeWithAttributeName:@"articleName" InEntityWithEntityName:@"Article" ForPreviousItems:[dict valueForKey:@"title"]]) {
                
                Article *article = [[Article alloc]initWithEntity:[NSEntityDescription entityForName:@"Article" inManagedObjectContext:[[CoreDataHelper sharedInstance]managedObjectContext]] insertIntoManagedObjectContext:[[CoreDataHelper sharedInstance]managedObjectContext]];
                article.articleName = [dict objectForKey:@"title"];
                article.articleDescription = [dict objectForKey:@"description"];
                article.articleURL = [dict objectForKey:@"link"];
                article.articlePublishedDate = [dict valueForKey:@"pubDate"];
                article.articleAddedDate = [NSDate date];
                
                if (![[CoreDataHelper sharedInstance].managedObjectContext save:&error]) {
                    NSLog(@"Couldn't save: %@", error);
                }
            }
        }
        [self startGeneratingLayouts];
    }];
}

- (void)startGeneratingLayouts
{
    self.articles = [[CoreDataHelper sharedInstance] getObjectsForEntity:@"Article" withSortKey:nil andSortAscending:YES andContext:[CoreDataHelper sharedInstance].managedObjectContext];
    LayoutsGenerator *lg = [[LayoutsGenerator alloc]initWithArticlesCount:[[CoreDataHelper sharedInstance]countForEntity:@"Article" andContext:[CoreDataHelper sharedInstance].managedObjectContext]];
    self.layoutsAsCombinations = [lg doNumberCrunch];
    self.numberOfPages=self.layoutsAsCombinations.count;
    self.pageControl.numberOfPages=self.numberOfPages;
    [self arrangeSubViews:self.deviceOrientation];
    
}

- (void)arrangeSubViews:(UIInterfaceOrientation)orientation
{
    for (int idx=0;idx<self.layoutsAsCombinations.count;idx++) {
        
        LayoutViewExtention *view = [self configureView:[[self.layoutsAsCombinations objectAtIndex:idx] integerValue]];
        if (orientation==UIInterfaceOrientationPortrait || orientation==UIInterfaceOrientationPortraitUpsideDown) {
            view.frame=CGRectMake(idx*self.scrollView.bounds.size.width,0,self.scrollView.bounds.size.width,self.scrollView.bounds.size.height);
            self.scrollView.contentSize=CGSizeMake(self.numberOfPages*self.view.bounds.size.width,self.scrollView.bounds.size.height);
        }
        else{
            view.frame=CGRectMake(idx*self.scrollView.bounds.size.width,0,self.scrollView.bounds.size.width,self.scrollView.bounds.size.height);
            self.scrollView.contentSize=CGSizeMake(self.numberOfPages*self.view.bounds.size.width,self.scrollView.bounds.size.height);
        }
        if ([view isKindOfClass:[LayoutViewExtention class]])
            [self.scrollView addSubview:view];
    }
}

-(LayoutViewExtention *)configureView:(int)layoutToChoose
{
    LayoutViewExtention *layoutToReturn=nil;
    NSArray *tempArray = [self.articles subarrayWithRange:NSMakeRange(self.startIndex,layoutToChoose)];
    self.startIndex = self.startIndex + layoutToChoose;
    
    NSMutableDictionary* viewDictionary = [[NSMutableDictionary alloc] init];
    
    for (int i=0;i<tempArray.count;i++) {
        
        if (i==0) {
            Article *article = (Article *)[tempArray objectAtIndex:i];
            article.articleImageURL = [LNRUtils returnTheImageURL:article.articleDescription];
            NSLog(@"Url : %@",article.articleURL);
            if (article.articleImageURL)
                article.isArticleImageAvailable=[NSNumber numberWithBool:YES];
            ContentView *view1forLayout = [[ContentView alloc]initWithArticle:article];
            [self downloadImages:article andView:view1forLayout];
            view1forLayout.delegate=self;
            [viewDictionary setObject:view1forLayout forKey:@"view1"];
        }
        
        if (i==1) {
            Article *article = (Article *)[tempArray objectAtIndex:i];
            article.articleImageURL = [LNRUtils returnTheImageURL:article.articleDescription];
            if (article.articleImageURL)
                article.isArticleImageAvailable=[NSNumber numberWithBool:YES];
            ContentView *view2forLayout = [[ContentView alloc]initWithArticle:article];
            [self downloadImages:[tempArray objectAtIndex:i] andView:view2forLayout];
            view2forLayout.delegate=self;
            [viewDictionary setObject:view2forLayout forKey:@"view2"];
        }
        
        if (i==2) {
            Article *article = (Article *)[tempArray objectAtIndex:i];
            article.articleImageURL = [LNRUtils returnTheImageURL:article.articleDescription];
            if (article.articleImageURL)
                article.isArticleImageAvailable=[NSNumber numberWithBool:YES];
            ContentView *view3forLayout = [[ContentView alloc]initWithArticle:article];
            [self downloadImages:[tempArray objectAtIndex:i] andView:view3forLayout];
            view3forLayout.delegate=self;
            [viewDictionary setObject:view3forLayout forKey:@"view3"];
        }
        
        if (i==3) {
            Article *article = (Article *)[tempArray objectAtIndex:i];
            article.articleImageURL = [LNRUtils returnTheImageURL:article.articleDescription];
            if (article.articleImageURL)
                article.isArticleImageAvailable=[NSNumber numberWithBool:YES];
            ContentView *view4forLayout = [[ContentView alloc]initWithArticle:article];
            [self downloadImages:[tempArray objectAtIndex:i] andView:view4forLayout];
            view4forLayout.delegate=self;
            [viewDictionary setObject:view4forLayout forKey:@"view4"];
        }
        
        if (i==4) {
            Article *article = (Article *)[tempArray objectAtIndex:i];
            article.articleImageURL = [LNRUtils returnTheImageURL:article.articleDescription];
            if (article.articleImageURL)
                article.isArticleImageAvailable=[NSNumber numberWithBool:YES];
            ContentView *view5forLayout = [[ContentView alloc]initWithArticle:article];
            [self downloadImages:[tempArray objectAtIndex:i] andView:view5forLayout];
            view5forLayout.delegate=self;
            [viewDictionary setObject:view5forLayout forKey:@"view5"];
        }
        
        if (i==5) {
            Article *article = (Article *)[tempArray objectAtIndex:i];
            article.articleImageURL = [LNRUtils returnTheImageURL:article.articleDescription];
            if (article.articleImageURL)
                article.isArticleImageAvailable=[NSNumber numberWithBool:YES];
            ContentView *view6forLayout = [[ContentView alloc]initWithArticle:article];
            [self downloadImages:[tempArray objectAtIndex:i] andView:view6forLayout];
            view6forLayout.delegate=self;
            [viewDictionary setObject:view6forLayout forKey:@"view6"];
        }
        
    }
    
    Class class =  NSClassFromString([NSString stringWithFormat:@"Layout%d",[self chooseLayoutRandomly:layoutToChoose]]);
    id layoutObject = [[class alloc] init];
    
    if ([layoutObject isKindOfClass:[LayoutViewExtention class]] ) {
        
        layoutToReturn = (LayoutViewExtention*)layoutObject;
        [layoutToReturn setFrame:CGRectMake(10,self.scrollView.bounds.origin.y,self.scrollView.bounds.size.width,self.scrollView.bounds.size.height)];
        [layoutToReturn initalizeViews:viewDictionary];
        [layoutToReturn rotate:self.interfaceOrientation animation:NO];
        layoutToReturn.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return layoutToReturn;
}

- (int)chooseLayoutRandomly:(int)layoutNo
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    [dictionary setObject:[NSArray arrayWithObjects:@"5", nil] forKey:@"6"];
    [dictionary setObject:[NSArray arrayWithObjects:@"2",@"3",@"4", nil] forKey:@"5"];
    [dictionary setObject:[NSArray arrayWithObjects:@"6", nil] forKey:@"4"];
    [dictionary setObject:[NSArray arrayWithObjects:@"1",nil] forKey:@"3"];
    
    NSArray *array = [dictionary objectForKey:[NSString stringWithFormat:@"%d",layoutNo]];
    NSUInteger randomIndex = arc4random() % [array count];
    return [[array objectAtIndex:randomIndex]integerValue];
}

- (void)downloadImages:(Article *)article andView:(ContentView *)contentView
{
    
    dispatch_queue_t fetchQ = dispatch_queue_create("Image Downloader", NULL);
    dispatch_async(fetchQ, ^{
        if (article.articleImageURL) {
            NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[article.articleImageURL stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]];
            //article.articleImage = [UIImage imageWithData:imgData];
            article.isArticleImageAvailable=[NSNumber numberWithBool:YES];
            if (contentView && ![contentView isKindOfClass:[NSNull class]]) {
                //contentView.contentImageView.image=article.articleImage;
                [contentView reAdjustLayout];
            }
        }
    });
}

#pragma mark- ScrollView Delegates

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.currentPage=[self indexOfSelectedPage];
    self.pageControl.currentPage=self.currentPage;
    if ([self indexOfSelectedPage] == self.numberOfPages)
    {
        self.numberOfPages++;
        self.pageControl.numberOfPages = self.numberOfPages;
    }
}

- (NSUInteger)indexOfSelectedPage
{
	CGFloat width = self.scrollView.bounds.size.width;
	int currentPage = (self.scrollView.contentOffset.x + width/2.0f) / width;
	return currentPage;
}

#pragma mark- Orientation Handling Methods

-(BOOL)shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

-(void)changeOrientation:(UIInterfaceOrientation)orientation
{
    if (orientation==UIInterfaceOrientationPortrait || orientation==UIInterfaceOrientationPortraitUpsideDown)
        self.view.frame=CGRectMake(0, 20, 768, 1004);
    else
        self.view.frame=CGRectMake(0, 20, 1024, 748);
    
    self.scrollView.frame=CGRectMake(0, HEADER_HEIGHT, self.view.frame.size.width, self.view.frame.size.height-HEADER_HEIGHT-FOOTER_HEIGHT);
   
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    self.deviceOrientation= toInterfaceOrientation;

    if (toInterfaceOrientation==UIInterfaceOrientationPortrait || toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
        self.view.frame=CGRectMake(0, 20, 768, 1004);
    else
        self.view.frame=CGRectMake(0, 20, 1024, 748);
    
    self.scrollView.frame=CGRectMake(0, HEADER_HEIGHT, self.view.frame.size.width, self.view.frame.size.height-HEADER_HEIGHT-FOOTER_HEIGHT);
    self.scrollView.contentSize=CGSizeMake(self.numberOfPages*self.scrollView.frame.size.width,self.scrollView.frame.size.height);
    [self resetLayoutViews];
}

-(void)resetLayoutViews {
    
    NSArray *subviews = self.scrollView.subviews;
    for (int i=0;i<subviews.count;i++) {
        if ([[subviews objectAtIndex:i] isKindOfClass:[LayoutViewExtention class]]) {
            LayoutViewExtention *layoutView = (LayoutViewExtention *)[subviews objectAtIndex:i];
            layoutView.frame=CGRectMake(i*self.scrollView.bounds.size.width,self.scrollView.bounds.origin.y,self.scrollView.bounds.size.width,self.scrollView.bounds.size.height);
            [layoutView rotate:self.deviceOrientation animation:NO];
        }
    }
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.scrollView setContentOffset:CGPointMake([self.scrollView bounds].size.width * self.currentPage, 0.0f) animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
