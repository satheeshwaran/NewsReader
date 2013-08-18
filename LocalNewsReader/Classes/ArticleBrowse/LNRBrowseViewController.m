//
//  LNRBrowseViewController.m
//  LocalNewsReader
//
//  Created by Admin on 8/18/13.
//  Copyright (c) 2013 Satheeshwaran. All rights reserved.
//

#import "LNRBrowseViewController.h"
#import "LNRTransport.h"

@interface LNRBrowseViewController ()

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
    [self fetchFeed];
}

-(void)fetchFeed {
    
    LNRTransport *feedTrans = [[LNRTransport alloc]initWithURL:[NSURL URLWithString:FEED_URL] andWithDetails:nil];
    [feedTrans makeHTTPRequest];
    [feedTrans setCompletionHandler:^(NSData *responseData, int status) {
        
        NSString *responseStr = [[NSString alloc]initWithBytes:[responseData bytes] length:[responseData length] encoding:NSUTF8StringEncoding];
        NSLog(@"Response : %@",responseStr);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
