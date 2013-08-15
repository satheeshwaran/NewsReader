//
//  LayoutViewExtention.m
//  Layouts
//
//  Created by Manikandan K on 12/03/13.
//  Copyright (c) 2013 Cognizant. All rights reserved.
//

#import "LayoutViewExtention.h"

@implementation LayoutViewExtention

@synthesize currrentInterfaceOrientation;
@synthesize isFullScreen;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIColor *color1=[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
        [self setBackgroundColor:color1];
    }
    return self;
}

-(void)rotate:(UIInterfaceOrientation)interfaceOrientation animation:(BOOL)animation{
	currrentInterfaceOrientation = interfaceOrientation;
	
	[self reAdjustLayout];
}


-(void)reAdjustLayout {
	//view extending this class can overide this method
}

-(void)initalizeViews:(NSDictionary*)viewCollectionDictonary {
	//view extending this class can overide this method
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
