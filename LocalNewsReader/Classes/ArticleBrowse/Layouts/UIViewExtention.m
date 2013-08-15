//
//  UIViewExtention.m
//  Layouts
//
//  Created by Manikandan K on 12/03/13.
//  Copyright (c) 2013 Cognizant. All rights reserved.
//

#import "UIViewExtention.h"

@implementation UIViewExtention

@synthesize currrentInterfaceOrientation;
@synthesize isFullScreen;
@synthesize originalRect;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
