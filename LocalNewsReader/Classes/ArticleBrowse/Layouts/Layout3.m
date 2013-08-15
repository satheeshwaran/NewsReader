//
//  Layout3.m
//  Layouts
//
//  Created by Manikandan K on 12/03/13.
//  Copyright (c) 2013 Cognizant. All rights reserved.
//

#import "Layout3.h"
#import "UIViewExtention.h"
#import <QuartzCore/QuartzCore.h>

@implementation Layout3

@synthesize view1;
@synthesize view2;
@synthesize view3;
@synthesize view4;
@synthesize view5;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)initalizeViews:(NSDictionary*)viewCollectionDictonary {
    
    view1 = (UIViewExtention*)[viewCollectionDictonary objectForKey:@"view1"];
    view2 = (UIViewExtention*)[viewCollectionDictonary objectForKey:@"view2"];
    view3 = (UIViewExtention*)[viewCollectionDictonary objectForKey:@"view3"];
    view4 = (UIViewExtention*)[viewCollectionDictonary objectForKey:@"view4"];
    view5 = (UIViewExtention*)[viewCollectionDictonary objectForKey:@"view5"];
    
    [view1 setBackgroundColor:[UIColor whiteColor]];
	[view2 setBackgroundColor:[UIColor whiteColor]];
	[view3 setBackgroundColor:[UIColor whiteColor]];
    [view4 setBackgroundColor:[UIColor whiteColor]];
    [view5 setBackgroundColor:[UIColor whiteColor]];
    
    [self addSubview:view1];
    [self addSubview:view2];
    [self addSubview:view3];
    [self addSubview:view4];
    [self addSubview:view5];
}

-(void)rotate:(UIInterfaceOrientation)orientation animation:(BOOL)animation {
    
    [view1 setBackgroundColor:[UIColor whiteColor]];
	[view2 setBackgroundColor:[UIColor whiteColor]];
	[view3 setBackgroundColor:[UIColor whiteColor]];
	[view4 setBackgroundColor:[UIColor whiteColor]];
	[view5 setBackgroundColor:[UIColor whiteColor]];
    
    for (UIView* myview in [self subviews]) {
		if ([myview isKindOfClass:[UIViewExtention class]]) {
			if (self.isFullScreen) {
				if (!((UIViewExtention*)myview).isFullScreen) {
					[((UIViewExtention*)myview) setAlpha:0];
				}
			}else {
				[((UIViewExtention*)myview) setAlpha:1];
			}
		}
	}
	
	if (animation) {
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.50];
	}
    
	if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
		if (view1 != nil) {
            int y = 2;
			[view1 setFrame:CGRectMake(0, y, super.frame.size.width /2, (super.frame.size.height/2)-2)];
            [view2 setFrame:CGRectMake((super.frame.size.width/2)+GAP, y, (super.frame.size.width /2)-GAP, (super.frame.size.height /2)-2)];
            
            y = (super.frame.size.height/2)+GAP;
            [view3 setFrame:CGRectMake(0, y, super.frame.size.width /3, (super.frame.size.height/2)-GAP)];
            [view4 setFrame:CGRectMake(view3.frame.origin.x+view3.frame.size.width+GAP, y, (super.frame.size.width/3)-GAP, (super.frame.size.height/2)-GAP)];
            [view5 setFrame:CGRectMake(view4.frame.origin.x+view4.frame.size.width+GAP, y, (super.frame.size.width/3)-GAP, (super.frame.size.height/2)-GAP)];
            
		}
	}else {
		if (view1 != nil) {
			
            int y = 2;
			[view1 setFrame:CGRectMake(0, y, super.frame.size.width/2, (super.frame.size.height/2)-2)];
            [view2 setFrame:CGRectMake((super.frame.size.width/2)+GAP, y, super.frame.size.width/2, (super.frame.size.height/2)-2)];
            
            y = (super.frame.size.height/2)+GAP;
            [view3 setFrame:CGRectMake(0, y, super.frame.size.width/3, super.frame.size.height/2)];
            [view4 setFrame:CGRectMake(view3.frame.origin.x+view3.frame.size.width+GAP, y, (super.frame.size.width/3)-GAP, super.frame.size.height/2)];
            [view5 setFrame:CGRectMake(view4.frame.origin.x+view4.frame.size.width+GAP, y,(super.frame.size.width/3)-GAP, super.frame.size.height/2)];
            
		}
    }
    
    if (animation) {
        
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(animationEnd:finished:context:)];
		[UIView commitAnimations];
        
	}else {
        
		for (UIView* myview in [self subviews]) {
			if ([myview isKindOfClass:[UIViewExtention class]]) {
				[((UIViewExtention*)myview) setAlpha:1];
			}
		}
    }
    
    for (UIView* myview in [self subviews]) {
		if ([myview isKindOfClass:[UIViewExtention class]]) {
			[((UIViewExtention*)myview) rotate:orientation animation:YES];
		}
	}
}

- (void)animationEnd:(NSString*)animationID finished:(NSNumber*)finished context:(void*)context {
    
    for (UIView* myview in [self subviews]) {
		if ([myview isKindOfClass:[UIViewExtention class]]) {
			[((UIViewExtention*)myview) setAlpha:1];
		}
	}
    
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
